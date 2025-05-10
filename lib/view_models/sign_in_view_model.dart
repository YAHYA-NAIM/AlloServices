import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignInViewModel extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final errortext = "".obs;

  RxBool obscureText = true.obs;
  RxBool rememberMe = false.obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  void togglePasswordVisibility() {
    obscureText.value = !obscureText.value;
  }

  void toggleRememberMe(bool? value) {
    rememberMe.value = value ?? false;
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
    await prefs.setBool('isRemembered', rememberMe.value);
  }

  Future<void> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      errortext.value=AppLocalizations.of(context)!.errorFillFields;
      return;
    }

    if (!_isValidEmail(email)) {
      errortext.value = AppLocalizations.of(context)!.errorInvalidEmail;
      return;
    }

    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (!(user?.emailVerified ?? false)) {
        errortext.value = AppLocalizations.of(context)!.errorEmailNotVerified;

        return;
      }

      final doc = await _firestore.collection('users').doc(user!.uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          await _cacheUserData(data);
        }
      }

      Get.offAllNamed('/home');
    }  on FirebaseAuthException catch (e) {
  switch (e.code) {
  case 'user-not-found':
    errortext.value = AppLocalizations.of(context)!.errorUserNotFound;
  break;
  case 'wrong-password':
    errortext.value = AppLocalizations.of(context)!.errorWrongPassword;
  break;
  case 'invalid-email':
    errortext.value = AppLocalizations.of(context)!.errorInvalidEmail;
  break;
  default:
  errortext.value = "An error occurred: ${e.message}";
  }
  }
}

  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      if (googleAuth == null) return;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data();
          if (data != null) {
            await _cacheUserData(data);
          }
        }
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isRemembered', true);
        Get.offAllNamed('/home');
      }
    } on FirebaseAuthException catch (e) {
      print("Google Sign-In Error, ${e.message} ?? An error occurred.");
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/forgot');
  }

  void goToSignUp() {
    Get.toNamed('/signup');
  }
  Future<void> autoLoginIfRemembered() async {
    final prefs = await SharedPreferences.getInstance();
    final isRemembered = prefs.getBool('isRemembered') ?? false;

    if (!isRemembered) return;

    final user = _auth.currentUser;
    if (user != null && user.emailVerified) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          await _cacheUserData(data);
          Get.offAllNamed('/home');
        }
      }
    }
  }


  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
