import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/extensions/string_extension.dart';
import 'package:smart_todo/features/home/presentation/bloc/todo_bloc.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          switch (state) {
            case FetchTodosSuccess():
              return ListView.builder(
                itemCount: state.todoList.length,
                itemBuilder: (context, index) {
                  final todo = state.todoList[index];
                  final timeStamp = todo.dueDate;
                  final dueDate = timeStamp.toDate();
                  final formatedDate =
                      DateFormat(AppConstants.dateFormatShort).format(dueDate);

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.spacing12,
                      vertical: AppConstants.spacing8,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius:
                            BorderRadius.circular(AppConstants.radius20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.black.withOpacity(0.05),
                            blurRadius: AppConstants.radius16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.darkGrey.withOpacity(0.08),
                        ),
                      ),
                      child: Padding(
                        padding: AppConstants.padding16,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Top Row (Priority + Date)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppConstants.radius12,
                                    vertical: AppConstants.radius8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getPriorityColor(todo.priority)
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(
                                      AppConstants.radius12,
                                    ),
                                  ),
                                  child: Text(
                                    todo.priority.toUpperCase(),
                                    style:
                                        context.textTheme.labelLarge?.copyWith(
                                      color: _getPriorityColor(todo.priority),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  formatedDate,
                                  style: context.textTheme.labelLarge?.copyWith(
                                    color: AppColors.darkGrey.withOpacity(0.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppConstants.spacing12),

                            // Title
                            Text(
                              todo.title.capitalizeFirst(),
                              style: context.textTheme.titleLarge?.copyWith(
                                color: AppColors.darkGrey,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacing8),

                            // Description
                            Text(
                              todo.description.capitalizeFirst(),
                              style: context.textTheme.bodyLarge?.copyWith(
                                color: AppColors.darkGrey.withOpacity(0.5),
                              ),
                            ),
                            const SizedBox(height: AppConstants.spacing12),

                            // Subtle divider + Action row (optional)
                            Divider(
                              color: AppColors.darkGrey.withOpacity(0.08),
                              height: 1,
                            ),
                            const SizedBox(height: AppConstants.spacing12),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.edit_outlined,
                                  color: AppColors.darkGrey.withOpacity(0.5),
                                  size: AppConstants.icon20,
                                ),
                                const SizedBox(width: AppConstants.spacing12),
                                Icon(
                                  Icons.delete_outline,
                                  color: AppColors.errorRed.withOpacity(0.5),
                                  size: AppConstants.icon20,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            case _:
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return AppColors.errorRed;
      case 'medium':
        return AppColors.warningOrange;
      case 'low':
        return AppColors.successGreen;
      default:
        return AppColors.blue;
    }
  }
}
