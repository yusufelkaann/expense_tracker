import 'package:expense_tracker/pages/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../home/views/home_screen.dart'; // Import the HomeScreen

class SignUpScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProviderr>(context); // Fixed typo here

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
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
            TextField(
              controller: userNameController,
              decoration: const InputDecoration(labelText: "Username"),

            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Check if the input fields are not empty
                if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter email and password")),
                  );
                  return;
                }

                try {
                  // Attempt to sign up
                  await authProvider.signUp(
                    emailController.text,
                    passwordController.text,
                    userNameController.text
                  );

                  // Navigate to home screen after successful sign-up
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                } catch (error) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Sign-up failed: $error")),
                  );
                }
              },
              child: const Text("Sign Up"),
            ),
            const SizedBox(height: 20), // Added space for better UI
            const Text("If you already have an account"),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
                );
              },
              child: const Text("Sign in"),
            ),
          ],
        ),
      ),
    );
  }
}
