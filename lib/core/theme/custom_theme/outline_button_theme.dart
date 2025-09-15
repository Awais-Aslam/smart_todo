import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class TOutlineButtonTheme {
  TOutlineButtonTheme._();

  /* -- dark outline button theme --*/
  static final lightOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.black,
      side: const BorderSide(color: AppColors.primaryPurple),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.black,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  /* -- dark outline button theme --*/
  static final darkOutlineButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: AppColors.white,
      side: const BorderSide(color: AppColors.primaryPurple),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      textStyle: const TextStyle(
        fontSize: 16,
        color: AppColors.white,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );
}
