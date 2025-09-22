import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/theme/custom_theme/appbar_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/bottom_sheet_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/checkbox_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/chip_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/elevated_button_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/outline_button_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/snakbar_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/text_button_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/text_field_theme.dart';
import 'package:smart_todo/core/theme/custom_theme/text_theme.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: ,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryPurple,
    textTheme: TTextTheme.lightTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
    appBarTheme: TAppbarTheme.lightAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.lightBottomSheetTheme,
    checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
    chipTheme: TChipTheme.lightChipTheme,
    outlinedButtonTheme: TOutlineButtonTheme.lightOutlineButtonTheme,
    inputDecorationTheme: TTextFieldTheme.lightInputDecorationTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryPurple,
      selectionColor: AppColors.primaryPurple,
      selectionHandleColor: AppColors.primaryPurple,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryPurple,
    ),
    snackBarTheme: SnakbarTheme.lightSnakBarTheme,
    textButtonTheme: TTextButtonTheme.lightTextButtonTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    // fontFamily: ,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.primaryPurple,
    textTheme: TTextTheme.darkTextTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
    appBarTheme: TAppbarTheme.darkAppBarTheme,
    bottomSheetTheme: TBottomSheetTheme.darkBottomSheetTheme,
    checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
    chipTheme: TChipTheme.darkChipTheme,
    outlinedButtonTheme: TOutlineButtonTheme.darkOutlineButtonTheme,
    inputDecorationTheme: TTextFieldTheme.darkInputDecorationTheme,
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.primaryPurple,
      selectionColor: AppColors.primaryPurple,
      selectionHandleColor: AppColors.primaryPurple,
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primaryPurple,
    ),
    snackBarTheme: SnakbarTheme.darkSnakBarTheme,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
  );
}
