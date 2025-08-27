import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FilterButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(30),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: const Icon(Icons.tune, color: Colors.white, size: 24),
          padding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
