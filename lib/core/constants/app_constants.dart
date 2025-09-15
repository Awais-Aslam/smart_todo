import 'package:flutter/material.dart';

class AppConstants {
  AppConstants._();

  // Spacing
  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
  static const double spacing16 = 16.0;
  static const double spacing24 = 24.0;
  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
  static const double spacing48 = 48.0;
  static const double spacing56 = 56.0;
  static const double spacing64 = 64.0;
  static const double spacing128 = 128.0;

  // Border Radius
  static const double radius8 = 8.0;
  static const double radius12 = 12.0;
  static const double radius16 = 16.0;
  static const double radius20 = 20.0;
  static const double radius24 = 24.0;

  // Icon Sizes
  static const double icon16 = 16.0;
  static const double icon24 = 24.0;
  static const double icon32 = 32.0;
  static const double icon40 = 40.0;
  static const double icon48 = 48.0;
  static const double icon56 = 56.0;
  static const double icon64 = 64.0;

  // Container Sizes
  static const double containerHeight24 = 24.0; // Very small (chips, badges)
  static const double containerHeight32 = 32.0; // Small buttons/avatars
  static const double containerHeight40 = 40.0; // Compact buttons/fields
  static const double containerHeight48 = 48.0; // Standard buttons
  static const double containerHeight56 = 56.0; // Large buttons/text fields
  static const double containerHeight64 = 64.0; // Cards, small tiles
  static const double containerHeight80 = 80.0; // Medium cards/avatars
  static const double containerHeight120 = 120.0; // Large cards
  static const double containerHeight160 = 160.0; // Banners
  static const double containerHeight200 = 200.0; // Modals, big banners

  static const double containerWidth24 = 24.0;
  static const double containerWidth32 = 32.0;
  static const double containerWidth40 = 40.0;
  static const double containerWidth48 = 48.0;
  static const double containerWidth56 = 56.0;
  static const double containerWidth64 = 64.0;
  static const double containerWidth80 = 80.0;
  static const double containerWidth120 = 120.0;
  static const double containerWidth160 = 160.0;
  static const double containerWidth200 = 200.0;
  static const double containerWidth300 = 300.0; // Dialogs, modals
  static const double containerWidth400 = 400.0; // Max content width

  // Button Heights
  static const double buttonHeight36 = 36.0;
  static const double buttonHeight48 = 48.0;
  static const double buttonHeight56 = 56.0;

  // Card Elevation
  static const double elevation2 = 2.0;
  static const double elevation4 = 4.0;
  static const double elevation8 = 8.0;

  // Animation Durations
  static const Duration animation200ms = Duration(milliseconds: 200);
  static const Duration animation300ms = Duration(milliseconds: 300);
  static const Duration animation500ms = Duration(milliseconds: 500);

  // Screen Breakpoints
  static const double breakpoint600 = 600.0; // Mobile
  static const double breakpoint900 = 900.0; // Tablet
  static const double breakpoint1200 = 1200.0; // Desktop

  // Common Padding
  static const EdgeInsets padding8 = EdgeInsets.all(spacing8);
  static const EdgeInsets padding16 = EdgeInsets.all(spacing16);
  static const EdgeInsets padding24 = EdgeInsets.all(spacing24);
  static const EdgeInsets padding32 = EdgeInsets.all(spacing32);

  // Common Margins
  static const EdgeInsets margin8 = EdgeInsets.all(spacing8);
  static const EdgeInsets margin16 = EdgeInsets.all(spacing16);
  static const EdgeInsets margin24 = EdgeInsets.all(spacing24);
  static const EdgeInsets margin32 = EdgeInsets.all(spacing32);

  // Horizontal Padding
  static const EdgeInsets paddingHorizontal8 =
      EdgeInsets.symmetric(horizontal: spacing8);
  static const EdgeInsets paddingHorizontal16 =
      EdgeInsets.symmetric(horizontal: spacing16);
  static const EdgeInsets paddingHorizontal24 =
      EdgeInsets.symmetric(horizontal: spacing24);

  // Vertical Padding
  static const EdgeInsets paddingVertical8 =
      EdgeInsets.symmetric(vertical: spacing8);
  static const EdgeInsets paddingVertical16 =
      EdgeInsets.symmetric(vertical: spacing16);
  static const EdgeInsets paddingVertical24 =
      EdgeInsets.symmetric(vertical: spacing24);

  // App Specific Constants
  static const String appName = 'Smart Todo';
  static const String appVersion = '1.0.0';
  static const String appDescription = 'Organize Your Life';

  // Todo Status
  static const String todoStatusPending = 'pending';
  static const String todoStatusInProgress = 'in_progress';
  static const String todoStatusCompleted = 'completed';
  static const String todoStatusCancelled = 'cancelled';

  // Priority Levels
  static const String priorityLow = 'low';
  static const String priorityMedium = 'medium';
  static const String priorityHigh = 'high';
  static const String priorityUrgent = 'urgent';

  // Categories
  static const String categoryPersonal = 'personal';
  static const String categoryWork = 'work';
  static const String categoryHealth = 'health';
  static const String categoryShopping = 'shopping';
  static const String categoryOther = 'other';

  // Date Formats
  static const String dateFormatShort = 'MMM dd, yyyy';
  static const String dateFormatLong = 'EEEE, MMMM dd, yyyy';
  static const String timeFormat12 = 'h:mm a';
  static const String timeFormat24 = 'HH:mm';

  // Validation
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 500;
  static const int maxCategoryLength = 50;

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache
  static const Duration cacheExpiration24h = Duration(hours: 24);
  static const int maxCacheSize = 100;

  // Network
  static const Duration networkTimeout30s = Duration(seconds: 30);
  static const int maxRetryAttempts = 3;

  // UI Constants
  static const double maxContentWidth600 = 600.0;
  static const double minTouchTarget44 = 44.0;
  static const double maxButtonWidth200 = 200.0;

  // Animation Curves
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveBounce = Curves.elasticOut;
  static const Curve curveFast = Curves.fastOutSlowIn;
}
