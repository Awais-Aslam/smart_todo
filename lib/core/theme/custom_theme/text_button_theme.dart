import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static TextButtonThemeData lightTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
      foregroundColor: AppColors.mediumGrey,
    ),
  );

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      textStyle: const TextStyle(fontSize: 14),
      foregroundColor: AppColors.mediumGrey,
    ),
  );
}
