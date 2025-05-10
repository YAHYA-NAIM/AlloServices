import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/services.dart';


class ServiceRepository {
  final String baseUrl = 'https://yahya-naim.github.io/API/Services.json';

  Future<ServiceCategory?> fetchCategoryByKey(String categoryKey) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        print("API Response received for $categoryKey");
        final jsonData = json.decode(response.body);
        final categories = jsonData['categories'] as List;

        for (var cat in categories) {
          if (cat['key'] == categoryKey) {
            print("Found category data for $categoryKey");
            return ServiceCategory.fromJson(cat);
          }
        }

        print("Category $categoryKey not found in API response");
      } else {
        print("API returned status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching category data: $e");
    }

    return null;
  }
}
