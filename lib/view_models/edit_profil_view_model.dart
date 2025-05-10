import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class EditProfileViewModel extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  RxString profileImageUrl = ''.obs;
  String? previousImagePublicId;

  @override
  void onInit() {
    super.onInit();
    loadUserData();
  }

  Future<void> loadUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      final data = doc.data();
      if (data != null) {
        firstNameController.text = data['firstName'] ?? '';
        lastNameController.text = data['lastName'] ?? '';
        emailController.text = data['email'] ?? '';
        phoneController.text = data['phone'] ?? '';
        addressController.text = data['address'] ?? '';
        profileImageUrl.value = data['profileImage'] ?? '';
        previousImagePublicId = data['profileImageId'];
      }
    } catch (e) {
      print('Error loading user data: $e');
    }
  }

  Future<void> updateUserData() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    try {
      await _firestore.collection('users').doc(uid).update({
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
        'email': emailController.text,
        'phone': phoneController.text,
        'address': addressController.text,
        'profileImage': profileImageUrl.value,
        'profileImageId': previousImagePublicId ?? '',
      });
      Get.offAllNamed('/home');
      print('Profile updated successfully');
    } catch (e) {
      print('Failed to update profile');
    }
  }

  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (pickedFile == null) return;

    final imageFile = File(pickedFile.path);

    try {

      if (previousImagePublicId != null && previousImagePublicId!.isNotEmpty) {
        final callable = FirebaseFunctions.instance.httpsCallable('deleteCloudinaryImage');
        await callable.call({'publicId': previousImagePublicId});
      }


      final url = Uri.parse('https://api.cloudinary.com/v1_1/di2azcvnl/image/upload');

      final request = http.MultipartRequest('POST', url)
        ..fields['upload_preset'] = 'upload_image'
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final resStr = await response.stream.bytesToString();
        final resJson = jsonDecode(resStr);

        profileImageUrl.value = resJson['secure_url'];
        previousImagePublicId = resJson['public_id'];
      }
    } catch (e) {
      print('Image upload failed');
    }
  }
}
