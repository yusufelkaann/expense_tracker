import 'package:expense_tracker/pages/home/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class SignInScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderr>(context); // Fixed typo here

    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Check if the input fields are not empty
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  // Show a snackbar or alert dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter email and password")),
                  );
                  return;
                }

                try {
                  // Attempt to sign in
                  await authProvider.signIn(
                    emailController.text,
                    passwordController.text,
                  );

                  // Navigate to home screen after successful sign-in
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } catch (error) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign-in failed: $error")),
                  );
                }
              },
              child: const Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
