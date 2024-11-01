import 'package:expense_tracker/pages/auth/sign_up.screen.dart';
import 'package:expense_tracker/pages/home/views/home_screen.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProviderr>(context);

    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), // Listen to auth state changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Show loading indicator while waiting
        }
        if (snapshot.hasData) {
          // User is signed in
          return HomeScreen(); // Navigate to Home Screen
        }
        // User is not signed in
        else{return SignUpScreen();} // Navigate to Sign In Screen
      },
    );
  }
}
