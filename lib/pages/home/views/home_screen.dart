import 'dart:math';
import 'package:expense_tracker/pages/balance%20pages/add_expense_screen.dart';
import 'package:expense_tracker/pages/balance%20pages/add_income_screen.dart'; // Import the add income screen
import 'package:expense_tracker/pages/home/views/main_Screen.dart';
import 'package:flutter/material.dart';
import '../../stats/stats.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var widgetList = [
    MainScreen(),
    SettingsScreen(),
  ];

  int index = 0;
  late Color selectedColor = Colors.blue;
  Color unselectedColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          backgroundColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 8,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: index == 0 ? selectedColor : unselectedColor,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.stacked_bar_chart,
                color: index == 1 ? selectedColor : unselectedColor,
              ),
              label: 'Stats',
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showIncomeExpenseDialog(context); // Show dialog on FAB press
        },
        shape: const CircleBorder(),
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.tertiary,
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.primary,
              ],
              transform: const GradientRotation(pi / 4),
            ),
          ),
          child: const Icon(Icons.add),
        ),
      ),
      body: index == 0 ? MainScreen() : SettingsScreen(),
    );
  }

  // Dialog to ask if user wants to add Income or Expense
  void _showIncomeExpenseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Add Entry"),
        content: Text("Would you like to add an Income or an Expense?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => IncomeEntryPage()),
              ); // Navigate to Income Entry Page
            },
            child: Text("Income"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the dialog
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExpenseEntryPage()),
              ); // Navigate to Expense Entry Page
            },
            child: Text("Expense"),
          ),
        ],
      ),
    );
  }
}
