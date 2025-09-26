import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/utils/app_snackbar.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/auth/presentation/widgets/login_form.dart';
import 'package:smart_todo/l10n/l10n.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            LoginButtonPressed(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  Future<void> _signInWithGoogle() async {
    context.read<AuthBloc>().add(GoogleSignInRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.appStrings.authWelcomeBack,
          style: context.textTheme.headlineMedium?.copyWith(
            color: AppColors.white,
          ),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case LoginSuccess():
              context.go(AppRoutes.home);
              break;
            case LoginError():
              AppSnackbar.showError(context, state.message);
              break;
            case GoogleSignInSuccess():
              context.go(AppRoutes.home);
              break;
            case GoogleSignInError():
              AppSnackbar.showError(context, state.message);
              break;
            case _:
              break;
          }
        },
        builder: (context, state) {
          switch (state) {
            case AuthLoading():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case _:
              return GestureDetector(
                onTap: () {
                  context.hideKeyboard();
                },
                child: Padding(
                  padding: AppConstants.paddingHorizontal16,
                  child: SingleChildScrollView(
                    child: Center(
                      child: LoginForm(
                        emailController: emailController,
                        passwordController: passwordController,
                        formKey: formKey,
                        onLogin: _loginUser,
                        signInWithGoogle: _signInWithGoogle,
                      ),
                    ),
                  ),
                ),
              );
          }
        },
      ),
    );
  }
}
