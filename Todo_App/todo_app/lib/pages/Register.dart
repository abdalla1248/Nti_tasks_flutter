import 'package:flutter/material.dart';
import 'package:todo_app/pages/HomePage.dart';
import 'package:todo_app/pages/Login.dart';

import '../widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _obscurePassword = true;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String? _usernameError;
  String? _passwordError;
  String? _confirmPasswordError;

  void validateAndRegister() {
    setState(() {
      _usernameError = null;
      _passwordError = null;
      _confirmPasswordError = null;
    });

    String username = _usernameController.text.trim();
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    bool isValid = true;

    if (username.isEmpty) {
      _usernameError = 'Please enter a username';
      isValid = false;
    }

    if (password.isEmpty) {
      _passwordError = 'Please enter a password';
      isValid = false;
    } else if (password.length < 6) {
      _passwordError = 'Password must be at least 6 characters';
      isValid = false;
    }

    if (confirmPassword.isEmpty) {
      _confirmPasswordError = 'Please confirm your password';
      isValid = false;
    } else if (confirmPassword != password) {
      _confirmPasswordError = 'Passwords do not match';
      isValid = false;
    }

    if (isValid) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          HomePage(name: _usernameController.text)),
                );
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/flag.png',
                height: 200,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CustomTextField(
                      labelText: 'Username',
                      hintText: 'Enter your username',
                      prefixIcon: Icons.person,
                      controller: _usernameController,
                      errorText: _usernameError,
                      obscureText: false,
                      obscuringCharacter: '*',
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      labelText: 'Password',
                      hintText: 'Enter your password',
                      prefixIcon: Icons.lock,
                      controller: _passwordController,
                      errorText: _passwordError,
                      obscureText: _obscurePassword,
                      obscuringCharacter: '*',
                      showVisibilityToggle: true,
                      onVisibilityToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    const SizedBox(height: 20),

                    CustomTextField(
                      labelText: 'Confirm Password',
                      hintText: 'Re-enter password',
                      prefixIcon: Icons.lock,
                      controller: _confirmPasswordController,
                      errorText: _confirmPasswordError,
                      obscureText: true,
                      obscuringCharacter: '*',
                    ),

                    const SizedBox(height: 30),

                    // Register Button
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.green,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: validateAndRegister,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: Colors.green[600],
                        ),
                        child: const Text(
                          "Register",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const Login()),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
