import 'package:expense_tracker/services/balance_service.dart';
import 'package:flutter/material.dart';

class BalanceProvider with ChangeNotifier{
  final BalanceService _balanceService = BalanceService();
  double? _balance;

  double? get balance => _balance;

  Future<void> fetchBalance(String userId) async{
    _balance = await _balanceService.getBalance(userId);
    notifyListeners();
  }

  Future<void> updateBalance(String userId, double balance) async {
    await _balanceService.updateBalance(userId, balance);
    _balance = await _balanceService.getBalance(userId);
    notifyListeners();
  }

}