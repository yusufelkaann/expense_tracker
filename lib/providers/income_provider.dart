

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/providers/balance_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class IncomeProvider with ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Income> _incomes = [];

  List<Income> get incomes => _incomes;

  Future<void> fetchIncomes(String userId) async {
    try {
      final snapshot = await _firestore.collection('users/$userId/incomes').get();
      print('Fetched ${snapshot.docs.length} incomes'); // Debugging info
      _incomes = snapshot.docs.map((doc) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}'); // Debugging info
        return Income.fromFirestore(doc.data(), doc.id);
      }).toList();
      
      notifyListeners();
    } catch (e) {
      print('Error fetching incomes: $e'); // Improved error logging
    }
  }

  Future<void> addIncome(Income income, String userId, BalanceProvider balanceProvider) async {
    try {
      await _firestore.collection('users/$userId/incomes').add(income.toMap());
      _incomes.add(income);

      double? currentBalance = balanceProvider.balance;
      if(currentBalance != null) {
        double updateBalance = currentBalance + income.amount;
        await balanceProvider.updateBalance(userId, updateBalance);
      }

      notifyListeners();
    }catch(e){
      print('error adding incomes: $e');
    }
  }
  double get totalIncome {
    return _incomes.fold(0, (total, income) => total + income.amount);
  }
} 