import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';

class AppPopup {
  static Future<bool?> showConfirmLogoutPopup(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirm Logout'),
          content: const Text('Are you sure you want to logout?'),
          actionsPadding: AppConstants.padding8,
          actions: [
            TextButton(
              onPressed: () {
                context.pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.pop(true);
              },
              child: Text(
                'Logout',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.errorRed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  static Future<bool?> showDeleteConfirmationDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: const Text('Are you sure you want to delete this item?'),
          actionsPadding: AppConstants.padding8,
          actions: [
            TextButton(
              onPressed: () {
                context.pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.pop(true);
              },
              child: Text(
                'Delete',
                style: context.textTheme.bodyMedium?.copyWith(
                  color: AppColors.errorRed,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
