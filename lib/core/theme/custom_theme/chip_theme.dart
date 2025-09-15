import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class TChipTheme {
  TChipTheme._();

  // light chip theme
  static final lightChipTheme = ChipThemeData(
    disabledColor: AppColors.mediumGrey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AppColors.black),
    selectedColor: AppColors.primaryPurple,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppColors.white,
  );

  // dark chip theme
  static const darkChipTheme = ChipThemeData(
    disabledColor: AppColors.mediumGrey,
    labelStyle: TextStyle(color: AppColors.white),
    selectedColor: AppColors.primaryPurple,
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: AppColors.white,
  );
}
