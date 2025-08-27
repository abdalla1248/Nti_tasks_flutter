import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/core/helpers/validator_helper.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/widgets/app_button.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/view/HomePage.dart';
import '../cubit/login_cubit/login_cubit.dart';
import '../cubit/login_cubit/login_state.dart';
import 'register.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HomePage(username: state.username),
                  ),
                );
              } else if (state is LoginFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error)),
                );
              }
            },
            builder: (context, state) {
              final cubit = LoginCubit.get(context);
              return Form(
                key: cubit.formKey,
                child: Column(
                  children: [
                    Image.asset(
                      AppAssets.flag,
                      height: 298.h,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField(
                        controller: cubit.emailController,
                        hintText: 'Email',
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(AppAssets.profile),
                        ),
                        validator: ValidatorHelper.validateEmail,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: CustomTextField(
                        hintText: 'Password',
                        controller: cubit.passwordController,
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(AppAssets.password),
                        ),
                        validator: ValidatorHelper.validatePassword,
                        obscureText: cubit.obscurePassword,
                        obscuringCharacter: '*',
                        showVisibilityToggle: true,
                        onVisibilityToggle: () {
                          cubit.togglePasswordVisibility();
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green,
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: state is LoginLoading
                              ? const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(12.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                )
                              : AppButton(
                                  onPressed: () {
                                    if (cubit.formKey.currentState!
                                        .validate()) {
                                      cubit.login();
                                    }
                                  },
                                  text: "Login",
                                ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Don’t Have An Account?'),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterPage()),
                            );
                          },
                          child: const Text('Register'),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
