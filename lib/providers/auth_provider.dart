import 'package:expense_tracker/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  // Method to sign in with Google
  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
    notifyListeners();
  }

  // Method to sign out
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;// to clear user information
    notifyListeners();
  }
}
