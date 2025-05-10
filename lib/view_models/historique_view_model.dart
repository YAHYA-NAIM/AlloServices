import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/historyItem.dart';

class HistoryViewModel extends GetxController {
  var isLoading = true.obs;
  var historyItems = <HistoryItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      isLoading.value = true;
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) return;

      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('orderedServices')
          .orderBy('orderDate', descending: true)
          .get();

      final items = snapshot.docs.map((doc) {
        final data = doc.data();
        return HistoryItem(
          categoryName: data['serviceName'] ?? '',
          subCategories: List<String>.from(data['subServices'] ?? []),
          date: (data['orderDate'] as Timestamp).toDate().toString().split(' ')[0],
        );
      }).toList();

      historyItems.assignAll(items);
    } catch (e) {
      print('Error fetching history: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
