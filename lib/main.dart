import 'package:expense_tracker/app.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/balance_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProviderr()), 
        ChangeNotifierProvider(create: (_) => BalanceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
