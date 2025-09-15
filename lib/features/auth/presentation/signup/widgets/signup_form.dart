import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/validators/validators.dart';
import 'package:smart_todo/core/widgets/app_button.dart';
import 'package:smart_todo/core/widgets/app_text_field.dart';
import 'package:smart_todo/l10n/l10n.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.confirmPasswordController,
    required this.passwordController,
    required this.formKey,
    required this.onRegister,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;
  final Future<void> Function() onRegister;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spacing128),
          Text(
            context.appStrings.authRegister,
            style: context.textTheme.headlineLarge,
          ),
          const SizedBox(height: AppConstants.spacing32),
          AppTextField(
            key: const ValueKey('name_key'),
            controller: nameController,
            validator: Validators.validateName,
            hintText: context.appStrings.formName,
          ),
          const SizedBox(height: AppConstants.spacing16),
          AppTextField(
            key: const ValueKey('email_key'),
            controller: emailController,
            validator: Validators.validateEmail,
            hintText: context.appStrings.authEmail,
          ),
          const SizedBox(height: AppConstants.spacing16),
          AppTextField(
            key: const ValueKey('password_key'),
            controller: passwordController,
            validator: Validators.validatePassword,
            hintText: context.appStrings.authPassword,
            obscureText: true,
          ),
          const SizedBox(height: AppConstants.spacing16),
          AppTextField(
            key: const ValueKey('confirm_password_key'),
            controller: confirmPasswordController,
            validator: (value) => Validators.validateConfirmPassword(
              value,
              passwordController.text,
            ),
            hintText: context.appStrings.formConfirmPassword,
            obscureText: true,
          ),
          const SizedBox(height: AppConstants.spacing32),
          AppButton(
            key: const ValueKey('register_btn_key'),
            onPressed: onRegister,
            title: context.appStrings.authRegister,
          ),
          const SizedBox(height: AppConstants.spacing32),
          GestureDetector(
            onTap: () {
              // will navigate to login screen
              if (context.canPop()) {
                context.pop();
              } else {
                context.go('/login');
              }
            },
            child: Text(
              context.appStrings.authBackToLogin,
              style: context.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }
}
