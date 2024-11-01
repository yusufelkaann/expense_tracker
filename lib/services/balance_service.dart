// user_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BalanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Method to update user's balance
  Future<void> updateBalance(String userId, double balance) async {
    try {
      await _firestore.collection('users').doc(userId).update({'balance': balance});
    } catch (e) {
      print("Failed to update balance: $e");
      throw Exception("Failed to update balance");
    }
  }

  // Method to get user's balance
  Future<double?> getBalance(String userId) async {
    try {
      final doc = await _firestore.collection('users').doc(userId).get();
      return doc.data()?['balance']?.toDouble();
    } catch (e) {
      print("Failed to get balance: $e");
      return null;
    }
  }
}
