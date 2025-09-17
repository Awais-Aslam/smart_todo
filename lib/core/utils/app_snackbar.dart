import 'package:flutter/material.dart';
import 'package:smart_todo/core/constants/app_colors.dart';

class AppSnackbar {
  /// Show success snackbar
  static void showSuccess(BuildContext context, String message) {
    _show(context, message, AppColors.primaryPurple);
  }

  /// Show error snackbar
  static void showError(BuildContext context, String message) {
    _show(context, message, AppColors.errorRed);
  }

  /// Show info/warning snackbar
  static void showInfo(BuildContext context, String message) {
    _show(context, message, AppColors.darkGrey);
  }

  /// Private helper
  static void _show(BuildContext context, String message, Color bgColor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        backgroundColor: bgColor,
        duration: const Duration(seconds: 4),
      ),
    );
  }
}
