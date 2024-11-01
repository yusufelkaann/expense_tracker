import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker/models/expense_model.dart';
import 'package:expense_tracker/providers/balance_provider.dart';
import 'package:flutter/material.dart';

class ExpenseProvider with ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> fetchExpenses(String userId) async {
  try {
    final snapshot = await _firestore.collection('users/$userId/expenses').get();
    print('Fetched ${snapshot.docs.length} expenses'); // Debugging info
    _expenses = snapshot.docs.map((doc) {
      print('Document ID: ${doc.id}, Data: ${doc.data()}'); // Debugging info
      return Expense.fromFirestore(doc.data(), doc.id);
    }).toList();
    
    notifyListeners();
  } catch (e) {
    print('Error fetching expenses: $e'); // Improved error logging
  }
}


  //add a new expense
  Future<void> addExpense(Expense expense, String userId, BalanceProvider balanceProvider) async {
    try {
      // Add expense to Firestore
      await _firestore.collection('users/$userId/expenses').add(expense.toMap());
      _expenses.add(expense);
      
      // Calculate updated balance
      double? currentBalance = balanceProvider.balance;
      if (currentBalance != null) {
        double updatedBalance = currentBalance - expense.amount;
        await balanceProvider.updateBalance(userId, updatedBalance); // Update balance in Firestore
      }

      notifyListeners();
    } catch (e) {
      print('Error adding expense: $e');
    }
  }
  double get totalExpenses {
    return _expenses.fold(0, (total, expense) => total + expense.amount);
  }
}