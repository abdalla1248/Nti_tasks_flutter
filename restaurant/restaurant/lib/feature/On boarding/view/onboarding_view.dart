import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:restaurant/core/helpers/navigate.dart';
import 'package:restaurant/core/utils/app_assets.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/core/utils/app_paddings.dart';
import 'package:restaurant/core/utils/app_text_styles.dart';
import 'package:restaurant/core/widgets/app_button.dart';
import 'package:restaurant/feature/auth/view/welcom_view.dart';
import '../cubit/onboarding_cubit.dart';

class OnboardingView extends StatelessWidget {
  OnboardingView({super.key});

  final PageController _pageController = PageController();

  final List<Map<String, String>> onboardingData = [
    {
      "image": AppAssets.orderForFood,
      "icon": AppAssets.transferDocument,
      "title": "Order For Food",
      "desc":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna."
    },
    {
      "image": AppAssets.easyPayment,
      "icon": AppAssets.creditCard,
      "title": "Easy Payment",
      "desc":
          "Pay easily and securely with multiple options available at your fingertips."
    },
    {
      "image": AppAssets.fastDelivery,
      "icon": AppAssets.deliverBoy,
      "title": "Fast Delivery",
      "desc": "Get your food delivered quickly at your doorstep hassle-free!"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OnboardingCubit(),
      child: Scaffold(
        body: BlocBuilder<OnboardingCubit, int>(
          builder: (context, currentPage) {
            return Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      context.read<OnboardingCubit>().changePage(index),
                  itemCount: onboardingData.length,
                  itemBuilder: (context, index) {
                    final data = onboardingData[index];
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          data["image"]!,
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height:
                                338.h, // Adjust height as needed for content
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(32.r),
                              ),
                            ),
                            child: Padding(
                              padding: AppPaddings.horizontalPadding,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 24.h),
                                  SvgPicture.asset(data["icon"]!),
                                  SizedBox(height: 16.h),
                                  Text(data["title"]!,
                                      textAlign: TextAlign.center,
                                      style: AppTextStyles.title),
                                  SizedBox(height: 8.h),
                                  Text(
                                    data["desc"]!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.brown,
                                    ),
                                  ),
                                  const Spacer(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                      onboardingData.length,
                                      (dotIndex) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 3),
                                        width: currentPage == dotIndex
                                            ? 20.w
                                            : 10.w,
                                        height: 6.h,
                                        decoration: BoxDecoration(
                                          color: currentPage == dotIndex
                                              ? AppColors.orange
                                              : Colors.grey,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.w),
                                    child: AppButton(
                                      onPressed: () {
                                        if (currentPage <
                                            onboardingData.length - 1) {
                                          context
                                              .read<OnboardingCubit>()
                                              .nextPage(onboardingData.length);
                                          _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 400),
                                            curve: Curves.easeInOut,
                                          );
                                        } else {
                                          // Navigate to Home Screen
                                          AppNavigator.pushAndRemoveUntil(
                                            context,
                                            WelcomView(),
                                          );
                                        }
                                      },
                                      text: currentPage ==
                                              onboardingData.length - 1
                                          ? "Get Started"
                                          : "Next",
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                if (currentPage != onboardingData.length - 1)
                  Positioned(
                    top: 50.h,
                    right: 16.w,
                    child: TextButton(
                      onPressed: () {
                        context
                            .read<OnboardingCubit>()
                            .skipToLast(onboardingData.length);
                        _pageController.animateToPage(
                          onboardingData.length - 1,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Text(
                        "Skip",
                        style: TextStyle(
                          color: AppColors.orange,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
