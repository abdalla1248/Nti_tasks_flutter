import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/utils/app_colors.dart';
import 'package:todapp/core/widgets/app_button.dart';
import 'package:todapp/core/widgets/custom_text_field.dart';
import 'package:todapp/core/helpers/validator_helper.dart';
import 'package:todapp/core/widgets/image_manager/image_manager_view.dart';
import '../cubit/register_cubit/register_cubit.dart';
import '../cubit/register_cubit/register_state.dart';
import 'Login.dart';
import 'widget/custom_auth_image.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            // Navigate to Login page after success
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const Login()),
            );
          } else if (state is RegisterFailure) {
            // Show error in SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final cubit = RegisterCubit.get(context);

          return Scaffold(
            backgroundColor: AppColors.background,
            body: Form(
              key: cubit.formKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   ImageManagerView(
                      onImagePicked: (image)=> RegisterCubit.get(context).image = image,
                      imageBuilder:(image){
                        return CustomAuthImage(image: FileImage(File(image.path)),);
                      },
                      defaultBuilder: CustomAuthImage(),
                    ),
                    SizedBox(height: 23.h,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          CustomTextField(
                            hintText: 'Email',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.profile),
                            ),
                            controller: cubit.emailController,
                            validator: ValidatorHelper.validateEmail,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'phone number',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.profile),
                            ),
                            controller: cubit.phoneController,
                            validator: ValidatorHelper.phoneValidator,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            hintText: 'Username',
                            prefixIcon: IconButton(
                              onPressed: null,
                              icon: SvgPicture.asset(AppAssets.profile),
                            ),
                            controller: cubit.nameController,
                            validator: ValidatorHelper.validateNotEmpty,
                          ),
                          const SizedBox(height: 20),
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
                            validator: (value) =>
                                ValidatorHelper.validateConfirmPassword(
                                    value, cubit.passwordController.text),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: state is RegisterLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: AppButton(
                                onPressed: () {
                                  cubit.register();
                                },
                                text: "Register",
                              ),
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
