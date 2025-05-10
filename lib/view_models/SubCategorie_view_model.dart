import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Repository/mail_repository.dart';
import '../models/services.dart';
import '../Repository/category_repository.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SubCategoriesViewModel extends GetxController {
  final ServiceRepository _repo = ServiceRepository();
  final EmailRepository _emailRepository = Get.find<EmailRepository>(); // Inject EmailRepository

  var subServices = <SubService>[].obs;
  var isLoading = false.obs;
  var selectedSubServices = <SubService>[].obs;
  String? serviceName;

  void toggleSubService(SubService subService) {
    if (selectedSubServices.contains(subService)) {
      selectedSubServices.remove(subService);
    } else {
      selectedSubServices.add(subService);
    }
  }

  Future<void> loadSubServices(String categoryKey) async {
    isLoading.value = true;
    final category = await _repo.fetchCategoryByKey(categoryKey);
    if (category != null) {
      subServices.value = category.subServices;
      serviceName = categoryKey;
    } else {
      subServices.value = [];
      serviceName = null;
    }
    isLoading.value = false;
  }

  Future<void> submitOrder(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _showErrorDialog(context, AppLocalizations.of(context)!.loginRequiredError);
      return;
    }

    final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if (!userDoc.exists) {
      _showErrorDialog(context, AppLocalizations.of(context)!.userNotFoundError);
      return;
    }

    final userData = userDoc.data()!;
    final phone = userData['phone'];
    final address = userData['address'];

    if (phone == null || phone.isEmpty || address == null || address.isEmpty) {
      _showErrorDialog(context, AppLocalizations.of(context)!.profileIncompleteError);
      return;
    }

    final subServiceNamesEn = selectedSubServices.map((s) => s.nameEn).toList();

    final orderData = {
      'serviceName': serviceName ?? 'Service',
      'subServices': subServiceNamesEn,
      'orderDate': FieldValue.serverTimestamp(),
      'userName': "${userData['firstName']} ${userData['lastName']}",
      'email': user.email,
      'phone': userData['phone'],
      'address': userData['address'],
    };

    await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('orderedServices')
        .add(orderData);

    // Send the email
    await _emailRepository.sendOrderEmail(
      userName: "${userData['firstName']} ${userData['lastName']}",
      userEmail: user.email!,
      userPhone: userData['phone'],
      userAddress: userData['address'],
      serviceName: serviceName ?? 'Service',
      subServices: subServiceNamesEn,
    );

    // Show order confirmation dialog
    _showOrderConfirmationDialog(context, serviceName);

    selectedSubServices.clear();
  }

  void _showOrderConfirmationDialog(BuildContext context, String? serviceName) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent dismissing by tapping outside
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check, size: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.orderSubmitted,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.orderConfirmationMessage(serviceName ?? "Service"),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 60),
                    elevation: 4,
                  ),
                  child: Text(AppLocalizations.of(context)!.okButton, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.error, size: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.missingInfo,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    minimumSize: Size(double.infinity, 60),
                    elevation: 4,
                  ),
                  child: Text(AppLocalizations.of(context)!.okButton, style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}