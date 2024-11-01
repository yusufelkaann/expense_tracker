// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:expense_tracker/components/custom_row.dart';
import 'package:expense_tracker/components/edit_balance.dart';
import 'package:expense_tracker/data/data.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/balance_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderr>(context);
    final user = authProvider.user;
    final username = authProvider.username;

    final balanceProvider = Provider.of<BalanceProvider>(context);
    final balance = balanceProvider.balance;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                      Container(
                        width:50,
                        height:50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow.shade700,
                        ),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.yellow[800],  
                      )
                  ]),
                    const SizedBox(width: 8.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.outline,
                          ),
                        ),
                        Text(
                          user != null ? username ?? "User" : "User",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onBackground,
                          ),
                        ),
                
                
                      ],
                    ),
                    
                  ],
                ),
                IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
              ],
            ),
            const SizedBox(height:20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                  transform: const GradientRotation(pi / 4),
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 2,
                    color: Colors.grey.shade400,
                    offset: const Offset(5, 5),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Total Balance",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                  SizedBox(height: 12,),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SetBalancePage())
                      
                      );
                    }, 
                    child: Text(
                      user != null && balance != null ? "\$ ${balance.toStringAsFixed(2)}" : "\$ 0.0",
                      style: const TextStyle(
                        fontSize: 40,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),
                  SizedBox(height: 12,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IncomeWidget(
                          icon: Icons.arrow_downward,
                          iconColor: Colors.greenAccent, 
                          title: 'Income', 
                          titleStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ), 
                          amount: '2400', 
                          amountStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          )
                        ),
                        IncomeWidget(
                          icon: Icons.arrow_upward,
                          iconColor: Colors.redAccent, 
                          title: "Expenses", 
                          titleStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ), 
                          amount: '800', 
                          amountStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                          ),
                        ),  
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Transactions',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                GestureDetector(
                  onTap: (){},
                  child: Text(
                    'View All',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.outline,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            Expanded(
              child: ListView.builder(
                itemCount: transactionsData.length,
                itemBuilder: (context, int i){
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                        color: transactionsData[i]['color'],
                                        shape: BoxShape.circle
                                      ),
                                    ),
                                    transactionsData[i]['icon']
                                    
                                  ],
                                ),
                                const SizedBox(width:12,),
                                Text(
                                  transactionsData[i]['name'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  transactionsData[i]['totalAmount'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.onBackground,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  transactionsData[i]['date'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Theme.of(context).colorScheme.outline,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              
              ),
            ),
          ],
        ),
      ),
    );
  }
}