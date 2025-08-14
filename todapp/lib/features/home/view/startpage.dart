import 'package:flutter/material.dart';
import 'package:todapp/core/utils/app_assets.dart';
import 'package:todapp/core/utils/app_text_styles.dart';

import '../../auth/view/register.dart';

class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        
        spacing: 20,
        children: [
          Image.asset(
            AppAssets.start,
            height: 400,
          ),
          Text(
            'Welcome To  \n Do It !',
            textAlign: TextAlign.center,
            style: AppTextStyles.heading,
          ),
          Text(
            'Ready to conquer your tasks? \nLet\'s Do It together.',
            textAlign: TextAlign.center,
            style: AppTextStyles.caption,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: 50,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterPage(),
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
          )
        ],
      ),
    );
  }
}
