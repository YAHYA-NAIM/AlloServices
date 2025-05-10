import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../Repository/mail_repository.dart';
import '../../colors.dart';

class SettingsViewModel extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // User profile information
  RxString profileImageUrl = ''.obs;
  RxString fullName = ''.obs;

  // Preferences
  RxBool isDarkMode = false.obs;
  RxBool isNotificationsEnabled = true.obs;
  RxString selectedLanguage = 'English'.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserInfoFromFirestore();
    _loadUserPreferences();
  }

  // Load user's profile data from Firestore
  Future<void> loadUserInfoFromFirestore() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        profileImageUrl.value = data['profileImage'] ?? '';
        fullName.value = '${data['firstName']} ${data['lastName']}';
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  // Load user preferences (dark mode, notifications, and language)
  Future<void> _loadUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkMode.value = prefs.getBool('isDarkMode') ?? false;
    isNotificationsEnabled.value = prefs.getBool('isNotificationsEnabled') ?? true;
    selectedLanguage.value = prefs.getString('selectedLanguage') ?? 'English';
  }

  // Update preferences to SharedPreferences
  Future<void> updateUserPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode.value);
    await prefs.setBool('isNotificationsEnabled', isNotificationsEnabled.value);
    await prefs.setString('selectedLanguage', selectedLanguage.value);
    // Change language
    changeLanguage(selectedLanguage.value);
  }

  // Change the app language
  void changeLanguage(String languageCode) {
    Locale locale;
    switch (languageCode) {
      case 'العربية':
        locale = Locale('ar', '');
        break;
      case 'Français':
        locale = Locale('fr', '');
        break;
      case '中文':
        locale = Locale('zh', '');
        break;
      default:
        locale = Locale('en', '');
    }
    Get.updateLocale(locale);  // Dynamically update the locale
  }

  // Show success dialog after sending a support message
  void showSupportSuccessDialog() {
    showDialog(
      context: Get.context!,
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
                  backgroundColor: Colors.green,
                  child: Icon(Icons.check_circle_outline, size: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.thankYou,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.supportSentMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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
  void showSupportErrorDialog() {
    showDialog(
      context: Get.context!,
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
                  child: Icon(Icons.error_outline, size: 40, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  AppLocalizations.of(context)!.errorOccurred,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  AppLocalizations.of(context)!.errorSendingSupportMessage,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
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


  // Show support form dialog
  void showSupportFormDialog(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final messageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(AppLocalizations.of(context)!.helpSupportLabel, style: TextStyle(fontSize: 20)),
                  const SizedBox(height: 16),
                  // Name TextField
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fieldBackground,  // Updated with correct background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      labelText: AppLocalizations.of(context)!.fullNameLabel,
                    ),
                  ),
                  const SizedBox(height: 16),  // Added spacing between text fields
                  // Email TextField
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fieldBackground,  // Updated with correct background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      labelText: AppLocalizations.of(context)!.emailLabel,
                    ),
                  ),
                  const SizedBox(height: 16),  // Added spacing between text fields
                  // Message TextField
                  TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.fieldBackground,  // Updated with correct background color
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      labelText: AppLocalizations.of(context)!.messageLabel,
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 16),
                  // Send Button
                  ElevatedButton(
                    onPressed: () async {
                      Navigator.pop(context); // close the form
                      final success = await EmailRepository().sendSupportEmail(
                        name: nameController.text,
                        email: emailController.text,
                        message: messageController.text,
                      );
                      if (success) {
                        showSupportSuccessDialog();
                      } else {
                        showSupportErrorDialog();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: Size(double.infinity, 60), // Wider button
                    ),
                    child: Text(AppLocalizations.of(context)!.sendButton, style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  // Logout the user
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isRemembered', false);
      await _auth.signOut();
      Get.offAllNamed('/signin'); // Navigate to the login screen
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
