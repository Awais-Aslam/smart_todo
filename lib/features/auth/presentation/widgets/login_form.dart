import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/validators/validators.dart';
import 'package:smart_todo/core/widgets/app_button.dart';
import 'package:smart_todo/core/widgets/app_outline_button.dart';
import 'package:smart_todo/core/widgets/app_text_field.dart';
import 'package:smart_todo/l10n/l10n.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
    required this.onLogin,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final Future<void> Function() onLogin;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.spacing128),
          Text(
            context.appStrings.authLogin,
            style: context.textTheme.headlineLarge,
          ),
          const SizedBox(height: AppConstants.spacing32),
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
          const SizedBox(height: AppConstants.spacing32),
          AppButton(
            key: const ValueKey('login_btn_key'),
            onPressed: onLogin,
            title: context.appStrings.authLogin,
          ),
          const SizedBox(height: AppConstants.spacing32),
          AppOutlineButton(
            key: const ValueKey('g_login_btn_key'),
            onPressed: () {},
            title: context.appStrings.authLoginWithGoogle,
            icon: Icons.g_mobiledata_rounded,
          ),
          const SizedBox(height: AppConstants.spacing32),
          GestureDetector(
            onTap: () {
              // will navigate to signup screen
              context.push(AppRoutes.register);
            },
            child: RichText(
              key: const ValueKey('register_text_key'),
              text: TextSpan(
                text: context.appStrings.authDontHaveAccount,
                style: context.textTheme.bodyLarge,
                children: [
                  TextSpan(
                    text: context.appStrings.authRegister,
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: AppColors.primaryPurple,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
