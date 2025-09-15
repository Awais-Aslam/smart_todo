import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  // light elevated button theme
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primaryPurple,
      disabledForegroundColor: AppColors.mediumGrey,
      disabledBackgroundColor: AppColors.mediumGrey,
      side: const BorderSide(color: AppColors.primaryPurple),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );

  // dark elevated button theme
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      backgroundColor: AppColors.primaryPurple,
      disabledForegroundColor: AppColors.mediumGrey,
      disabledBackgroundColor: AppColors.mediumGrey,
      side: const BorderSide(color: AppColors.primaryPurple),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
    ),
  );
}
