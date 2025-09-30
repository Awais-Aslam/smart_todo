import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class TFloatingActionButtonTheme {
  TFloatingActionButtonTheme._();

  static FloatingActionButtonThemeData lightFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryPurple,
    foregroundColor: AppColors.white,
  );

  static FloatingActionButtonThemeData darkFloatingActionButtonTheme =
      const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primaryPurple,
    foregroundColor: AppColors.white,
  );
}
