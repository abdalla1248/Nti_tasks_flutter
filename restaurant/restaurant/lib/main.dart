import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restaurant/feature/auth/view/welcom_view.dart';
import 'package:restaurant/feature/home/view/home_view.dart';
import 'package:restaurant/feature/home/view/home_view.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(393, 852),
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: const HomeScreen(),
        ),
      ),
    );
  }
}
