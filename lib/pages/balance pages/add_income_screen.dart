import 'package:expense_tracker/models/income_model.dart';
import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:expense_tracker/providers/balance_provider.dart';
import 'package:expense_tracker/providers/income_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncomeEntryPage extends StatelessWidget {
  final TextEditingController amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  //const IncomeEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeProvider = Provider.of<IncomeProvider>(context);
    final authProvider = Provider.of<AuthProviderr>(context);
    final balanceProvider = Provider.of<BalanceProvider>(context);
    final userId = authProvider.user?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Income'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            TextButton(
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context, 
                  initialDate: selectedDate,
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2101)
                );
                if (pickedDate != null && pickedDate != selectedDate) {
                  selectedDate = pickedDate;
                }
              }, 
              child: Text('Select Date: ${selectedDate.toLocal()}'.split(' ')[0]),
            ),
            ElevatedButton(
              onPressed: () {
                final double amount = double.tryParse(amountController.text.trim()) ?? 0.0;
                if(userId != null) {
                  final income = Income(
                    id:'',
                    amount: amount,
                    date: selectedDate,
                  );
                  incomeProvider.addIncome(income, userId, balanceProvider);
                  Navigator.pop(context);
                }else{
                  print("user not logged in!");
                }
              }, 
              child: Text('Add Income')
            ),
          ],
        )
      ),
    );
  }
}