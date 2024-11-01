import 'dart:math';

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
  late Color selectedColor =Colors.blue;
  Color unselectedColor = Colors.grey;
  @override
  
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(30),
        ),
        child: BottomNavigationBar(
          onTap: (value){
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
          ]
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){},

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
            )
          ),
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
      body: index == 0
        ? MainScreen()
        : SettingsScreen(),
    );
  }
}