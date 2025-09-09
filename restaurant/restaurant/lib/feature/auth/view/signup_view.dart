import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helpers/navigate.dart';
import 'package:restaurant/core/helpers/validator_helper.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_size.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';
import 'package:restaurant/core/widgets/app_button.dart';
import 'package:restaurant/core/widgets/custom_text_field.dart';
import 'package:restaurant/feature/auth/view/welcom_view.dart';

import '../cubit/signup_cubit.dart';
import '../cubit/signup_state.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignupCubit(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            // navigate to next screen after success
            AppNavigator.pushAndRemoveUntil(context, WelcomView());
          }
          if (state is SignupError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final cubit = SignupCubit.get(context);

          return Scaffold(
            body: Container(
              color: AppColors.yellow,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  /// Top bar
                  Padding(
                    padding: EdgeInsets.only(
                      top: 76.h,
                      right: 35.w,
                      bottom: 16.h,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () =>
                              AppNavigator.pushAndRemoveUntil(context, WelcomView()),
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 110.w),
                        Text(
                          'Hello!',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SafeArea(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 689.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 36.w,
                            vertical: 34.h,
                          ),
                          child: Form(
                            key: cubit.formKey,
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Welcome Back',
                                    style: TextStyle(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.brown,
                                    ),
                                  ),
                                  SizedBox(height: 52.h),

                                  /// Full Name
                                  Text(
                                    'Full Name',
                                    style: AppTextStyles.title.copyWith(color: AppColors.brown),
                                  ),
                                  CustomTextField(
                                    hintText: "Enter your full name",
                                    controller: cubit.nameController,
                                    validator: (value) =>
                                        ValidatorHelper.validateNotEmpty('Full name is required'),
                                  ),
                                  AppSize.s22,

                                  /// Email
                                  Text(
                                    'Email',
                                    style: AppTextStyles.title.copyWith(color: AppColors.brown),
                                  ),
                                  CustomTextField(
                                    hintText: "example@domain.com",
                                    controller: cubit.emailController,
                                    validator: ValidatorHelper.validateEmail,
                                    keyboardType: TextInputType.emailAddress,
                                  ),
                                  AppSize.s22,

                                  /// Phone
                                  Text(
                                    'Phone Number',
                                    style: AppTextStyles.title.copyWith(color: AppColors.brown),
                                  ),
                                  CustomTextField(
                                    hintText: "0100000000",
                                    controller: cubit.phoneController,
                                    validator: ValidatorHelper.validatePhone,
                                    keyboardType: TextInputType.phone,
                                  ),
                                  AppSize.s22,

                                  /// Password
                                  Text(
                                    'Password',
                                    style: AppTextStyles.title.copyWith(color: AppColors.brown),
                                  ),
                                  CustomTextField(
                                    hintText: "Enter your password",
                                    controller: cubit.passwordController,
                                    obscureText: cubit.passwordSecure,
                                    showVisibilityToggle: true,
                                    onVisibilityToggle: cubit.changePasswordVisibility,
                                    validator: ValidatorHelper.validatePassword,
                                  ),
                                  AppSize.s22,

                                  /// Confirm Password
                                  Text(
                                    'Confirm Password',
                                    style: AppTextStyles.title.copyWith(color: AppColors.brown),
                                  ),
                                  CustomTextField(
                                    hintText: "Re-enter your password",
                                    controller: cubit.confirmPasswordController,
                                    obscureText: cubit.confirmPasswordSecure,
                                    showVisibilityToggle: true,
                                    onVisibilityToggle: cubit.changeConfirmPasswordVisibility,
                                    validator: (value) => ValidatorHelper.validateConfirmPassword(
                                        value, cubit.passwordController.text),
                                  ),
                                  AppSize.s60,

                                  /// Button
                                  Center(
                                    child: AppButton(
                                      text: state is SignupLoading ? "Loading..." : "Sign Up",
                                      textStyle: AppTextStyles.title.copyWith(
                                        color: AppColors.white,
                                      ),
                                      color: AppColors.orange,
                                      size: Size(207.w, 45.h),
                                      padding: EdgeInsets.only(top: 6.h, bottom: 9.h),
                                      onPressed: cubit.onSignupPressed,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
