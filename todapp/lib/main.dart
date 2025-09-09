import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/home/view/HomePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/home/view/splashpage.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/profile/cubit/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SettingsCubit(),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (context, widget) => MaterialApp(
          debugShowCheckedModeBanner: false,
          home: const Splashview(),
        ),
      ),
    );
  }
}