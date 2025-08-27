import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todapp/core/helpers/validator_helper.dart';

import '../../../core/utils/app_assets.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../home/view/HomePage.dart';
import '../cubit/changepass_cubit.dart';
import '../cubit/changepass_state.dart';

class Changepass extends StatelessWidget {
  const Changepass({super.key, required this.name, this.password});
  final String name;
  final String? password;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangepassCubit(),
      child: BlocBuilder<ChangepassCubit, ChangepassState>(
        builder: (context, state) {
          final cubit = ChangepassCubit.get(context);

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Top Image
                    SizedBox(
                      width: double.infinity,
                      height: 298.h,
                      child: Image.asset(
                        AppAssets.flag,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Old Password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: cubit.oldpasswordController,
                        labelText: 'Old password',
                        validator: (val) {
                          if (cubit.oldpasswordController.text != password) {
                            return 'Wrong password';
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

                    // New Password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: cubit.newpasswordController,
                        labelText: 'New password',
                        validator: (p0) =>
                            ValidatorHelper.validatePassword(p0),
                        obscureText: true,
                        obscuringCharacter: '*',
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(AppAssets.password),
                        ),
                      ),
                    ),

                    // Confirm Password
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextField(
                        controller: cubit.conpasswordController,
                        labelText: 'Confirm password',
                        validator: (p0) =>
                            ValidatorHelper.validateConfirmPassword(
                                p0, cubit.newpasswordController.text),
                        obscureText: true,
                        obscuringCharacter: '*',
                        prefixIcon: IconButton(
                          onPressed: null,
                          icon: SvgPicture.asset(AppAssets.password),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Save Button
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
                            if (cubit.formKey.currentState!.validate()) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Password changed successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(username: name),
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
        },
      ),
    );
  }
}
