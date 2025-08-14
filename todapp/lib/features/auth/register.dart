import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/widgets/app_button.dart';
import '../../core/helpers/validator_helper.dart';
import '../../core/widgets/custom_text_field.dart';
import '../home/HomePage.dart';
import 'Login.dart';

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

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState!.validate()) {
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
                    builder: (context) => HomePage(
                        name: _usernameController.text,
                        password: _passwordController.text),
                  ),
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                AppAssets.flag,
                height: 298.h,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextSelectionTheme(
                      data: TextSelectionThemeData(
                          selectionColor:
                              const Color.fromARGB(255, 140, 139, 139)
                                  .withOpacity(.30)),
                      child: CustomTextField(
                        hintText: 'Username',
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(AppAssets.profile),
                        ),
                        controller: _usernameController,
                        errorText: null,
                        obscureText: false,
                        obscuringCharacter: '*',
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a username';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Password',
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(AppAssets.password),
                      ),
                      controller: _passwordController,
                      errorText: null,
                      obscureText: _obscurePassword,
                      obscuringCharacter: '*',
                      showVisibilityToggle: true,
                      onVisibilityToggle: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      validator: (value) => ValidatorHelper.validatePassword(value),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      hintText: 'Confirm Password',
                      prefixIcon: IconButton(
                        onPressed: null,
                        icon: SvgPicture.asset(AppAssets.password),
                      ),
                      controller: _confirmPasswordController,
                      errorText: null,
                      obscureText: true,
                      obscuringCharacter: '*',
                      validator: (value) => ValidatorHelper.validateConfirmPassword(value, _passwordController.text),
                    ),
                    const SizedBox(height: 30),
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
                      child: AppButton(
                        onPressed: _register,
                        text: "Register",
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
                         MaterialPageRoute(
                             builder: (context) => const Login()),
                       );
                     },
                     child: const Text('Login'),
                   ),
                 ],
               ),
            ],
          ),
        ),
      ),
    );
  }
}
