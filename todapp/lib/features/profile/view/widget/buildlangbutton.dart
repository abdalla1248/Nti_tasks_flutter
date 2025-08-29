
  import 'package:flutter/material.dart';

import '../../cubit/settings_cubit.dart';

Widget _buildLangButton(
      String langCode, String currentLang, SettingsCubit cubit, BuildContext context) {
    final isSelected = currentLang == langCode;
    return GestureDetector(
      onTap: () => cubit.changeLanguage(langCode),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          langCode,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }