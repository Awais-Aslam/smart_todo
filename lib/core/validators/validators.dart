import 'package:smart_todo/core/routes/app_router.dart';
import 'package:smart_todo/l10n/l10n.dart';

class Validators {
  Validators._();

  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return appContext.appStrings.validationEmailRequired;
    }

    // Simple email regex (keeps it lightweight)
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return appContext.appStrings.validationEmailInvalid;
    }

    return null; // valid
  }

  static String? validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      return appContext.appStrings.validationPasswordRequired;
    }

    if (value.length < 6) {
      return appContext.appStrings.validationPasswordMinLength;
    }

    return null;
  }

  static String? validateConfirmPassword(String? value, String? passwordValue) {
    if (value == null || value.trim().isEmpty) {
      return appContext.appStrings.validationConfirmPasswordRequired;
    }

    if (value != passwordValue) {
      return appContext
          .appStrings.validationPasswordConfirmPasswordDoNotMatched;
    }

    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return appContext.appStrings.validationNameRequired;
    }

    return null;
  }
}
