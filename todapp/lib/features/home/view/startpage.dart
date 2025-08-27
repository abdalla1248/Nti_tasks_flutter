import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/utils/app_text_styles.dart';
import 'package:todapp/features/auth/view/Login.dart';
import 'package:todapp/features/home/view/HomePage.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

void _checkLogin() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final username = user.displayName ?? "User";
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => HomePage(username: username),
      ),
    );
  }
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.start,
            height: 400,
          ),
          const SizedBox(height: 20),
          Text(
            'Welcome To  \n Do It !',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading,
          ),
          const SizedBox(height: 10),
          Text(
            'Ready to conquer your tasks? \nLet\'s Do It together.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption,
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                backgroundColor: Colors.green[600],
              ),
              child: Text('Let\'s Started', style: AppTextStyles.button),
            ),
          ),
        ],
      ),
    );
  }
}
