import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/utils/app_popup.dart';
import 'package:smart_todo/core/utils/app_snackbar.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/home/presentation/widgets/add_todo_bottom_sheet.dart';
import 'package:smart_todo/features/home/presentation/widgets/todo_type_selector.dart';
import 'package:smart_todo/l10n/l10n.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _handleLogout(BuildContext context) async {
    final shouldLogout = await AppPopup.showConfirmLogoutPopup(context);
    if (shouldLogout == true) {
      if (!context.mounted) return;
      context.read<AuthBloc>().add(LogoutButtonPressed());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case LogoutSuccess():
            context.go(AppRoutes.login);
            break;
          case LogoutError():
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
            return Scaffold(
              appBar: AppBar(
                title: Text(context.appStrings.appTitle),
                actions: [
                  IconButton(
                    onPressed: () => _handleLogout(context),
                    icon: const Icon(Icons.logout),
                    color: AppColors.white,
                  ),
                ],
              ),
              body: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppConstants.spacing8,
                  vertical: AppConstants.spacing16,
                ),
                child: Column(
                  children: [
                    TodoTypeSelector(),
                  ],
                ),
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddTodoBottomSheet(),
                  );
                },
                child: const Icon(Icons.add),
              ),
            );
        }
      },
    );
  }
}
