// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:todo_app/pages/StartPage.dart';

class SplashCard extends StatefulWidget {
  const SplashCard({super.key});

  @override
  State<SplashCard> createState() => _SplashCardState();
}

class _SplashCardState extends State<SplashCard> {
  @override
 void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const StartPage()),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/todo.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}