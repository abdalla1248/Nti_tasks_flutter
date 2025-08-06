import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_text_field.dart';
import 'package:todo_app/pages/HomePage.dart';

class Changepass extends StatefulWidget {
  const Changepass({super.key, required this.name});
  final String name;
  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top banner image
              SizedBox(
                width: double.infinity,
                height: 200,
                child: Image.asset(
                  'assets/flag.png',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30),

              // Password fields
              CustomTextField(
                labelText: 'Old password',
                obscureText: true,
                obscuringCharacter: '*',
                prefixIcon: Icons.lock,
              ),
              CustomTextField(
                labelText: 'New password',
                obscureText: true,
                obscuringCharacter: '*',
                prefixIcon: Icons.lock,
              ),
              CustomTextField(
                labelText: 'Confirm password',
                obscureText: true,
                obscuringCharacter: '*',
                prefixIcon: Icons.lock,
              ),

              const SizedBox(height: 40),

              // Save button
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.green,
                        blurRadius: 8,
                        spreadRadius: 1,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[600],
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 24),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onPressed: () {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Password changed successfully!'),
                          backgroundColor: Colors.green,
                        ),
                      );

                      // Navigate to HomePage after a short delay
                      Future.delayed(const Duration(seconds: 1), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(name: 'User'),
                          ),
                        );
                      });
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
