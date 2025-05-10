import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class EmailRepository extends GetxService {
  final String _emailEndpoint = 'https://formspree.io/f/mzzrgzjp'; // Shared for both

  // Send service order email
  Future<void> sendOrderEmail({
    required String userName,
    required String userEmail,
    required String userPhone,
    required String userAddress,
    required String serviceName,
    required List<String> subServices,
  }) async {
    final String formattedAddress = userAddress.isEmpty ? 'Not provided' : userAddress;
    final String messageBody = '''
New Order from $userName

Service Name: $serviceName

Selected Sub-Services:
${subServices.map((s) => "- $s").join('\n')}

User Info:
Email: $userEmail
Phone: $userPhone
Address: $formattedAddress

Contact the customer directly for further communication.
''';

    try {
      final response = await http.post(
        Uri.parse(_emailEndpoint),
        body: {
          'name': userName,
          'email': userEmail,
          'phone': userPhone,
          'address': formattedAddress,
          'message': messageBody,
        },
      );

      if ([200, 201, 302].contains(response.statusCode)) {
        print("Order email sent successfully!");
      } else {
        print("Failed to send order email. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("An error occurred while sending the order email: $e");
    }
  }

  // Send support message email
  Future<bool> sendSupportEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_emailEndpoint),
        body: {
          'name': name,
          'email': email,
          'message': message,
        },
      );

      if ([200, 201, 302].contains(response.statusCode)) {
        print("Support email sent successfully!");
        return true;
      } else {
        print("Failed to send support email. Status code: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("An error occurred while sending the support email: $e");
      return false;
    }
  }
}
