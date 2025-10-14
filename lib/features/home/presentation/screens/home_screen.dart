import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/routes/app_routes.dart';
import 'package:smart_todo/core/utils/app_popup.dart';
import 'package:smart_todo/core/utils/app_snackbar.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:smart_todo/features/home/presentation/widgets/add_todo_bottom_sheet.dart';
import 'package:smart_todo/features/home/presentation/widgets/todo_list_view.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TodoBloc>().add(FetchTodosEvent());
    });
  }

  Future<void> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  }) async {
    context.pop();
    context.read<TodoBloc>().add(
          AddTodoEvent(
            category: category,
            description: description,
            dueDate: dueDate,
            priority: priority,
            title: title,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
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
        ),
        BlocListener<TodoBloc, TodoState>(
          listener: (context, state) {
            switch (state) {
              case AddTodoSuccess():
                AppSnackbar.showSuccess(context, 'Todo added successfully');
                break;
              case AddTodoError():
                AppSnackbar.showError(context, state.message);
                break;
              case _:
                break;
            }
          },
        ),
      ],
      child: BlocBuilder<AuthBloc, AuthState>(
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
                      TodoListView(),
                    ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => AddTodoBottomSheet(
                        addTodo: ({
                          required String category,
                          required String description,
                          required String dueDate,
                          required String priority,
                          required String title,
                        }) {
                          return addTodo(
                              title: title,
                              description: description,
                              category: category,
                              priority: priority,
                              dueDate: dueDate);
                        },
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              );
          }
        },
      ),
    );
  }
}
