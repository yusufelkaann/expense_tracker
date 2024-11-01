import 'package:expense_tracker/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/balance_provider.dart';

class SetBalancePage extends StatelessWidget {
  const SetBalancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final balanceProvider = Provider.of<BalanceProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProviderr>(context, listen: false);
    final user = authProvider.user;

    // Initialize the TextEditingController outside the builder to avoid resets
    final TextEditingController balanceController = TextEditingController();

    if (user == null) {
      // Return early if user is null
      return Scaffold(
        appBar: AppBar(title: const Text("Set Balance")),
        body: const Center(
          child: Text("User not found. Please log in."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Set Balance")),
      body: FutureBuilder<void>(
        future: balanceProvider.fetchBalance(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          }

          // Set initial value if balance exists
          balanceController.text = (balanceProvider.balance ?? 0.0).toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Enter your current balance:",
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: balanceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Balance",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      final newBalance = double.tryParse(balanceController.text) ?? 0.0;
                      await balanceProvider.updateBalance(user.uid, newBalance);
                      Navigator.pop(context);
                    },
                    child: const Text("Save Balance"),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
