import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Colors.dart';

class SignUpViewModel extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxBool obscurePassword = true.obs;
  RxString countryCode = ''.obs;
  RxString phoneNumber = ''.obs;
  final errortext = "".obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  Future<void> _cacheUserData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('firstName', data['firstName']);
    await prefs.setString('lastName', data['lastName']);
    await prefs.setString('email', data['email']);
    await prefs.setString('phone', data['phone']);
    await prefs.setString('uid', data['uid']);
    await prefs.setBool('isRemembered', true);
  }

  Future<void> signUp() async {
    final firstName = firstNameController.text.trim();
    final lastName = lastNameController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final fullPhoneNumber = phoneNumber.value;

    if ([firstName, lastName, email, phone, password, confirmPassword].any((e) => e.isEmpty)) {
      errortext.value = AppLocalizations.of(Get.context!)!.errorFillFields;
      return;
    }

    if (!_isValidEmail(email)) {
      errortext.value = AppLocalizations.of(Get.context!)!.errorInvalidEmail;
      return;
    }

    if (password != confirmPassword) {
      errortext.value = AppLocalizations.of(Get.context!)!.passwordsDoNotMatch;
      return;
    }

    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final uid = userCredential.user!.uid;

      final userData = {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'phone': fullPhoneNumber,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
        'address': '',
        'profileImage': '',
        'profileImageId': '',
      };

      await _firestore.collection('users').doc(uid).set(userData);
      await _cacheUserData(userData);

      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        _showVerificationDialog();
      }
    } on FirebaseAuthException catch (e) {
      String message = switch (e.code) {
        'email-already-in-use' => AppLocalizations.of(Get.context!)!.emailAlreadyInUse,
        'weak-password' => AppLocalizations.of(Get.context!)!.weakPassword,
        _ => AppLocalizations.of(Get.context!)!.somethingWentWrong
      };
      errortext.value = message;
    } catch (_) {
      errortext.value = AppLocalizations.of(Get.context!)!.unexpectedErrorOccurred;
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final uid = user.uid;
        final displayNameParts = (googleUser.displayName ?? "User").split(" ");
        final firstName = displayNameParts.first;
        final lastName = displayNameParts.length > 1 ? displayNameParts.last : "";

        final userData = {
          'firstName': firstName,
          'lastName': lastName,
          'email': googleUser.email,
          'uid': uid,
          'createdAt': FieldValue.serverTimestamp(),
          'address': '',
          'profileImage': googleUser.photoUrl ?? '',
          'profileImageId': '',
        };

        await _firestore.collection('users').doc(uid).set(userData);
        await _cacheUserData(userData);

        Get.offAllNamed('/editProfile');
      }
    } on FirebaseAuthException catch (e) {
      errortext.value = e.message ?? AppLocalizations.of(Get.context!)!.googleSignInError;
    } catch (_) {
      errortext.value = AppLocalizations.of(Get.context!)!.googleSignInUnexpectedError;
    }
  }

  void goToSignIn() {
    Get.toNamed('/signin');
  }

  void _showVerificationDialog() {
    Get.dialog(
      Dialog(
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
              Text(AppLocalizations.of(Get.context!)!.emailVerificationSent,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text(
                AppLocalizations.of(Get.context!)!.checkInboxForVerification,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.back();
                  Get.offAllNamed('/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  minimumSize: Size(double.infinity, 60),
                ),
                child: Text(AppLocalizations.of(Get.context!)!.okButton, style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
