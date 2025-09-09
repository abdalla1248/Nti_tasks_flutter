import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/splash_view/views/splash_view.dart';
import 'feature/bookmark/bookmark_view.dart';
import 'feature/profile/view/profile_view.dart';
import 'feature/search/search_view.dart';
import 'features/explore_view/cubit/news_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, widget) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NewsCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashView(),
            '/bookmark': (context) => BookmarkView(),
            '/profile': (context) => ProfileView(),
            '/search': (context) => SearchView(),
          },
        ),
      ),
    );
  }
}
