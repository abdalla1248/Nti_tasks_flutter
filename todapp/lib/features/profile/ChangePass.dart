import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todapp/core/helpers/validator_helper.dart';

import '../../core/utils/app_assets.dart';
import '../../core/widgets/custom_text_field.dart';
import '../home/HomePage.dart';

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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: double.infinity,
                height: 298.h,
                child: Image.asset(
                  AppAssets.flag,
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
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(AppAssets.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: _newpasswordController,
                  labelText: 'New password',
                  validator: (p0) =>ValidatorHelper.validatePassword(p0),
                  obscureText: true,
                  obscuringCharacter: '*',
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(AppAssets.password),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  controller: _conpasswordController,
                  labelText: 'Confirm password',
                  validator: (p0) =>ValidatorHelper.validateConfirmPassword(p0, _newpasswordController.text),
                  obscureText: true,
                  obscuringCharacter: '*',
                  prefixIcon: IconButton(
                    onPressed: null,
                    icon: SvgPicture.asset(AppAssets.password),
                  ),
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
    );
  }
}
