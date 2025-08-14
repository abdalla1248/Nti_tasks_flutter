import 'package:flutter/material.dart';
import 'package:todapp/core/utils/app_assets.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 200,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "There are no tasks yet,\nPress the button\nTo add New Task",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 20),
            Image.asset(AppAssets.empty, height: 200),
          ],
        ),
      ),
    );
  }
}
