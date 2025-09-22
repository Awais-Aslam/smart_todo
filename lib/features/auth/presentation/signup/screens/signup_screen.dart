import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/utils/app_snackbar.dart';
import 'package:smart_todo/features/auth/presentation/signup/bloc/auth_bloc.dart';
import 'package:smart_todo/features/auth/presentation/signup/widgets/signup_form.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    if (formKey.currentState!.validate()) {
      debugPrint('SignupButtonPressed');

      context.hideKeyboard();

      context.read<AuthBloc>().add(
            SignupButtonPressed(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          switch (state) {
            case SignupSuccess():
              context.go(AppRoutes.home);
              break;
            case SignupError():
              AppSnackbar.showError(context, state.message);
              break;
            case _:
              // Do nothing for SignupInitial, SignupLoading, etc.
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
                      child: SignUpForm(
                        nameController: nameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        formKey: formKey,
                        onRegister: _registerUser,
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
