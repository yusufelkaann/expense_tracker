import 'package:expense_tracker/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class AuthProviderr with ChangeNotifier {
  final AuthService _authService = AuthService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? _user;
  String? _userName;

  User? get user => _user;
  String? get username => _userName;
  // Sign up method
  Future<void> signUp(String email, String password, String userName) async {
    _user = await _authService.signUpWithEmail(email, password, userName);
    _userName = userName;
    notifyListeners();
  }

  // Sign in method
  Future<void> signIn(String email, String password) async {
    _user = await _authService.signInWithEmail(email, password);
    notifyListeners();
  }

  // Sign out method
  Future<void> signOut() async {
    await _authService.signOut();
    _user = null;
    notifyListeners();
  }
}
