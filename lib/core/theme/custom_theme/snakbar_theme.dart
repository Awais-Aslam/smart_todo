import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class SnakbarTheme {
  SnakbarTheme._();

  static SnackBarThemeData lightSnakBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primaryPurple,
    contentTextStyle: const TextStyle(color: AppColors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  static SnackBarThemeData darkSnakBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.primaryPurple,
    contentTextStyle: const TextStyle(color: AppColors.white),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );
}
