import 'package:flutter/material.dart';

import '../../../core/widgets/custom_text_field.dart';

class SearchBarWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const SearchBarWidget({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
        ),
        child: CustomTextField(
          controller: controller,
          hintText: "Search...",
          onChanged: onChanged,
          suffixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
