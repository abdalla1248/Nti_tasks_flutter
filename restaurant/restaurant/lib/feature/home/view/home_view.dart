import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helpers/navigate.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/feature/home/cubit/home_state.dart';
import 'package:restaurant/feature/home/view/widgets/BestSellerSection.dart';
import 'package:restaurant/feature/home/view/widgets/CustomSearchBar.dart';
import 'package:restaurant/feature/home/view/widgets/PromotionBanner.dart';
import 'package:restaurant/feature/home/view/widgets/RecommendedSection.dart';
import '../cubit/home_cubit.dart';
import '../data/repo/home_repository.dart';
import 'menu_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(HomeRepo())..fetchHomeData(),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 220.h, // ✅ responsive
              width: double.infinity,
              color: const Color(0xFFFFC107),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w, // ✅ responsive
                vertical: 24.h, // ✅ responsive
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// 🔍 Search
                  CustomSearchBar(
                    onChanged: (query) {
                      context.read<HomeCubit>().searchProducts(query);
                    },
                    onCartTap: () {
                      debugPrint("🛒 Cart tapped!");
                    },
                  ),
                  SizedBox(height: 16.h), // ✅ responsive
                  Text(
                    'Good Morning',
                    style: TextStyle(
                      fontSize: 24.sp, // ✅ responsive
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    'Rise And Shine! It\'s Breakfast Time',
                    style: TextStyle(
                      fontSize: 14.sp, // ✅ responsive
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),

            /// ⚪ Main Content
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 680.h, // ✅ responsive
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r), // ✅ responsive
                    ),
                  ),
                  child: BlocBuilder<HomeCubit, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HomeLoaded) {
                        return RefreshIndicator(
                          onRefresh: () async {
                            context.read<HomeCubit>().fetchHomeData();
                          },
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 🔥 Best Seller
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Best Seller',
                                        style: TextStyle(
                                          fontSize: 18.sp, // ✅ responsive
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'View All',
                                            style: TextStyle(
                                              fontSize: 14.sp, // ✅ responsive
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 12.sp, // ✅ responsive
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                BestSellerSection(
                                  products: state.bestSellers?.products,
                                  isLoading: false,
                                ),

                                // 🎞 Slider
                                PromotionBanner(
                                  sliders: state.sliders,
                                  isLoading: false,
                                ),

                                // ⭐ Recommended
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.w,
                                    vertical: 16.h,
                                  ),
                                  child: Text(
                                    'Recommend',
                                    style: TextStyle(
                                      fontSize: 18.sp, // ✅ responsive
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                RecommendedSection(
                                  products: state.topRated?.products,
                                  isLoading: false,
                                ),
                                SizedBox(height: 16.h), // ✅ responsive
                              ],
                            ),
                          ),
                        );
                      } else if (state is HomeError) {
                        return Center(child: Text("❌ ${state.message}"));
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ),
            ),

            /// 🔻 Bottom Navigation Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.h, // ✅ responsive
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5722),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r), // ✅ responsive
                    topRight: Radius.circular(20.r), // ✅ responsive
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home,
                          color: Colors.white, size: 24.sp), // ✅ responsive
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.restaurant_menu,
                          color: Colors.white.withOpacity(0.6),
                          size: 24.sp), // ✅ responsive
                      onPressed: () => AppNavigator.pushReplacement(
                          context, MenuPage(products: [])), // Navigate to MenuPage
                    ),
                    IconButton(
                      icon: Icon(Icons.person,
                          color: Colors.white.withOpacity(0.6),
                          size: 24.sp), // ✅ responsive
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
