import 'package:flutter/material.dart';
import 'package:todo_app/widgets/custom_text_field.dart';
import 'package:todo_app/pages/HomePage.dart';

class Changepass extends StatefulWidget {
  Changepass({super.key, required this.name, this.password});
  final String name;
  final String? password;
  @override
  State<Changepass> createState() => _ChangepassState();
}

class _ChangepassState extends State<Changepass> {
  final TextEditingController _oldpasswordController = TextEditingController();
  final TextEditingController _newpasswordController = TextEditingController();
  final TextEditingController _conpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _oldpasswordController,
                    labelText: 'Old password',
                    validator: (val) {
                      if (_oldpasswordController.text != widget.password) {
                        return 'wrong password';
                      }
                      return null;
                    },
                    obscureText: true,
                    obscuringCharacter: '*',
                    prefixIcon: Icons.lock,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _newpasswordController,
                    labelText: 'New password',
                    validator: (p0) {
                      if (_oldpasswordController.text.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: true,
                    obscuringCharacter: '*',
                    prefixIcon: Icons.lock,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    controller: _conpasswordController,
                    labelText: 'Confirm password',
                    validator: (p0) {
                      if (_conpasswordController.text !=
                          _newpasswordController.text) {
                        return 'NOT Match';
                      }
                      return null;
                    },
                    obscureText: true,
                    obscuringCharacter: '*',
                    prefixIcon: Icons.lock,
                  ),
                ),

                const SizedBox(height: 40),

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
                        if (_formKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password changed successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const HomePage(name: 'User'),
                              ),
                            );
                          });
                        }
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
      ),
    );
  }
}
