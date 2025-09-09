import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/feature/home/view/home_view.dart';
import '../../../core/helpers/validator_helper.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_size.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../cubit/login_cubit.dart';
import '../cubit/login_state.dart';
import 'welcom_view.dart';
import '../../../core/helpers/navigate.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // Show loading indicator
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is LoginSuccess) {
            Navigator.pop(context); // remove loader
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful")),
            );

            // Navigate to Home
            AppNavigator.pushAndRemoveUntil(
              context,
              const HomeScreen(),
            );
          }
          if (state is LoginError) {
            Navigator.pop(context); // remove loader
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          final cubit = LoginCubit.get(context);
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
                          onPressed: () => AppNavigator.pushAndRemoveUntil(
                            context,
                            WelcomView(),
                          ),
                          icon:
                              const Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        SizedBox(width: 110.w),
                        Text(
                          'Hello!',
                          style: AppTextStyles.title.copyWith(
                            color: AppColors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// Form
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

                                /// Email
                                Text(
                                  'Email',
                                  style: AppTextStyles.title.copyWith(
                                    color: AppColors.brown,
                                  ),
                                ),
                                CustomTextField(
                                  hintText: "Enter your email",
                                  controller: cubit.usernameController,
                                  validator: ValidatorHelper.validateEmail,
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                AppSize.s22,

                                /// Password
                                Text(
                                  'Password',
                                  style: AppTextStyles.title.copyWith(
                                    color: AppColors.brown,
                                  ),
                                ),
                                CustomTextField(
                                  hintText: "Enter your password",
                                  controller: cubit.passwordController,
                                  obscureText: cubit.passwordSecure,
                                  showVisibilityToggle: true,
                                  onVisibilityToggle:
                                      cubit.changePasswordVisibility,
                                  validator: ValidatorHelper.validatePassword,
                                ),

                                AppSize.s60,

                                /// Button
                                Center(
                                  child: AppButton(
                                    text: 'Log In',
                                    textStyle: AppTextStyles.title.copyWith(
                                      color: AppColors.white,
                                    ),
                                    color: AppColors.orange,
                                    size: Size(207.w, 45.h),
                                    padding: EdgeInsets.only(
                                      top: 6.h,
                                      bottom: 9.h,
                                    ),
                                    onPressed: () => cubit.login(),
                                  ),
                                ),
                              ],
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
