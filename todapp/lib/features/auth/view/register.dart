import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/helpers/validator_helper.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/widgets/app_button.dart';
import 'package:todapp/core/widgets/custom_text_field.dart';
import 'package:todapp/features/auth/cubit/register_cubit/register_cubit.dart';
import 'package:todapp/features/home/view/HomePage.dart';
import '../cubit/register_cubit/register_state.dart';
import 'Login.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => HomePage(
                  name: RegisterCubit.get(context).nameController.text,
                  password: RegisterCubit.get(context).passwordController.text,
                ),
              ),
            );
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);

          return Scaffold(
            body: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: _selectedImage != null
                          ? Image.file(
                              _selectedImage!,
                              height: 298.h,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              AppAssets.flag,
                              height: 298.h,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          // Username field
                          CustomTextField(
                            hintText: 'Email',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.profile),
                            ),
                            controller: cubit.emailController,
                            obscureText: false,
                            validator: ValidatorHelper.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Username',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.profile),
                            ),
                            controller: cubit.nameController,
                            obscureText: false,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Please enter a username';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          // Password field
                          CustomTextField(
                            hintText: 'Password',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.password),
                            ),
                            controller: cubit.passwordController,
                            obscureText: cubit.obscurePassword,
                            showVisibilityToggle: true,
                            onVisibilityToggle: cubit.togglePasswordVisibility,
                            validator: ValidatorHelper.validatePassword,
                          ),
                          const SizedBox(height: 20),

                          // Confirm password field
                          CustomTextField(
                            hintText: 'Confirm Password',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.password),
                            ),
                            controller: cubit.confirmPasswordController,
                            obscureText: cubit.obscureConfirmPassword,
                            showVisibilityToggle: true,
                            onVisibilityToggle:
                                cubit.toggleConfirmPasswordVisibility,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != cubit.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Register button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: AppButton(
                          onPressed: () {
                            cubit.register();
                            AppNavigator.pushReplacement(
                              context,
                              const Login(),
                              
                            );
                          },
                          text: "Register",
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Navigate to login
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const Login()),
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
        },
      ),
    );
  }
}
