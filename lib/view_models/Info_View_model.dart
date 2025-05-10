import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class PersonalInfoViewModel extends GetxController {
  RxString firstName = ''.obs;
  RxString lastName = ''.obs;
  RxString email = ''.obs;
  RxString phone = ''.obs;
  RxString address = ''.obs;
  RxString profileImageUrl = ''.obs;


  RxString fullName = ''.obs;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadUserInfoFromFirestore();
  }

  Future<void> loadUserInfoFromFirestore() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      firstName.value = data['firstName'] ?? '';
      lastName.value = data['lastName'] ?? '';
      email.value = data['email'] ?? '';
      phone.value = data['phone'] ?? '';
      address.value = data['address'] ?? 'null';
      profileImageUrl.value = data['profileImage'] ?? '';

      fullName.value = '${firstName.value} ${lastName.value}';
    }
  }
}
