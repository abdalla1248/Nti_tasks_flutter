import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/core/helpers/navigate.dart';
import 'package:restaurant/core/utils/app_colors.dart';
import 'package:restaurant/feature/home/data/model/product_model.dart';
import 'package:restaurant/feature/home/view/home_view.dart';
import '../cubit/category_cubit.dart';
import 'item_view.dart';

class MenuPage extends StatelessWidget {
  final List<Product> products;

  const MenuPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryCubit(products),
      child: Scaffold(
        body: Stack(
          children: [
            /// Top colored header
            Container(
              height: 220.h,
              width: double.infinity,
              color: const Color(0xFFFFC107),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 24.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Choose your favorite meals',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.orange,
                    ),
                  ),
                ],
              ),
            ),

            /// Main content container
            SafeArea(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 680.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(32.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      // Categories
                      Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                        ),
                        child: SizedBox(
                          height: 90,
                          child: BlocBuilder<CategoryCubit, CategoryState>(
                            builder: (context, state) {
                              return ListView(
                                scrollDirection: Axis.horizontal,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                children: [
                                  _categoryItem(context, Icons.fastfood, 'Snacks', state.selectedCategory),
                                  _categoryItem(context, Icons.restaurant, 'Meal', state.selectedCategory),
                                  _categoryItem(context, Icons.local_dining, 'Vegan', state.selectedCategory),
                                  _categoryItem(context, Icons.cake, 'Dessert', state.selectedCategory),
                                  _categoryItem(context, Icons.local_drink, 'Drinks', state.selectedCategory),
                                  _categoryItem(context, Icons.all_inclusive, 'All', state.selectedCategory),
                                ],
                              );
                            },
                          ),
                        ),
                      ),

                      // Product list
                      Expanded(
                        child: BlocBuilder<CategoryCubit, CategoryState>(
                          builder: (context, state) {
                            final filteredProducts = state.filteredProducts;
                            if (filteredProducts.isEmpty) {
                              return Center(child: Text('No products found'));
                            }
                            return ListView.builder(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              itemCount: filteredProducts.length,
                              itemBuilder: (context, index) {
                                final product = filteredProducts[index];
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => ItemPage(product: product),
                                      ),
                                    );
                                  },
                                  child: Card(
                                    margin: EdgeInsets.only(bottom: 16.h),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(16.w),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(12.r),
                                            child: Image.network(
                                              product.imagePath,
                                              width: double.infinity,
                                              height: 150.h,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => Container(
                                                height: 150.h,
                                                color: Colors.grey[300],
                                                child: Icon(Icons.error, color: Colors.red),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                product.name,
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Container(
                                                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                                                decoration: BoxDecoration(
                                                  color: Colors.orange,
                                                  borderRadius: BorderRadius.circular(8.r),
                                                ),
                                                child: Text(
                                                  '${product.rating.toStringAsFixed(1)} ★',
                                                  style: TextStyle(color: Colors.white, fontSize: 12.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 4.h),
                                          Text(product.description, style: TextStyle(fontSize: 12.sp)),
                                          SizedBox(height: 4.h),
                                          Text(
                                            '\$${product.price.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            /// Bottom navigation bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xFFFF5722),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.home, color: Colors.white, size: 24.sp),
                      onPressed: () => AppNavigator.pushReplacement(context, HomeScreen()),
                    ),
                    IconButton(
                      icon: Icon(Icons.restaurant_menu, color: Colors.white, size: 24.sp),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.person, color: Colors.white, size: 24.sp),
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

  Widget _categoryItem(BuildContext context, IconData icon, String label, String? selectedCategory) {
    final isSelected = selectedCategory == label || (label == 'All' && selectedCategory == null);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: GestureDetector(
        onTap: () {
          context.read<CategoryCubit>().selectCategory(label == 'All' ? null : label);
        },
        child: Column(
          children: [
            CircleAvatar(
              radius: 30.r,
              backgroundColor: isSelected ? Colors.orange : Colors.white,
              child: Icon(icon, size: 30.sp, color: isSelected ? Colors.white : Colors.orange),
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
