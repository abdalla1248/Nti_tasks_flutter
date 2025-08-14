import 'package:flutter/material.dart';
import 'package:todapp/core/helpers/navigate.dart';
import 'package:todapp/features/home/HomePage.dart';
class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;

  const SuccessDialog({
    super.key,
    required this.title,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => AppNavigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
