import 'package:get/get.dart';
import '../Repository/category_repository.dart';
import '../models/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardViewModel extends GetxController {
  final ServiceRepository _repo = ServiceRepository();

  var firstName = "".obs;

  // Map to store subservices by category key
  var categorySubServices = <String, List<SubService>>{}.obs;

  // Map to track loading state by category key
  var loadingCategories = <String, bool>{}.obs;

  // Search related variables
  var searchQuery = "".obs;
  var isSearching = false.obs;
  var allCategories = <Map<String, String>>[].obs;
  var filteredCategories = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  // Load user data from SharedPreferences
  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    firstName.value = prefs.getString('firstName') ?? '';
  }

  // Initialize categories list
  void setCategories(List<Map<String, String>> categories) {
    allCategories.value = categories;
    filteredCategories.value = List.from(categories);
  }

  // Update search query and trigger search
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  // Perform search on categories
  void performSearch() {
    if (searchQuery.value.isEmpty) {
      filteredCategories.value = List.from(allCategories);
      isSearching.value = false;
    } else {
      isSearching.value = true;
      final query = searchQuery.value.toLowerCase();
      filteredCategories.value = allCategories.where((category) {
        return category["title"]!.toLowerCase().contains(query);
      }).toList();
    }
  }

  // Reset search
  void resetSearch() {
    searchQuery.value = '';
    filteredCategories.value = List.from(allCategories);
    isSearching.value = false;
  }

  // Updated method to fetch category data with better error handling
  Future<void> loadCategorySubServices(String categoryKey) async {
    // Only start loading if we haven't loaded this category before
    // or if we're not already loading it
    if (categorySubServices.containsKey(categoryKey) &&
        categorySubServices[categoryKey]!.isNotEmpty) {
      return; // Already loaded with data
    }

    if (loadingCategories[categoryKey] == true) {
      return; // Already loading, don't start again
    }

    // Set loading state
    loadingCategories[categoryKey] = true;
    update(); // Force update to show loading indicator

    try {
      final category = await _repo.fetchCategoryByKey(categoryKey);

      if (category != null && category.subServices.isNotEmpty) {
        categorySubServices[categoryKey] = category.subServices;
      } else {
        categorySubServices[categoryKey] = [];
      }
    } catch (e) {
      categorySubServices[categoryKey] = []; // Empty list on error
    } finally {
      loadingCategories[categoryKey] = false;
      update();
    }
  }

  // Helper to get services
  List<SubService> getSubServicesForCategory(String categoryKey) {
    return categorySubServices[categoryKey] ?? [];
  }

  // Helper to check if a category is loading
  bool isLoadingCategory(String categoryKey) {
    return loadingCategories[categoryKey] == true;
  }
}
