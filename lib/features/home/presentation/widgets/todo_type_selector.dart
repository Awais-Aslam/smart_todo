import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/constants/app_colors.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/extensions/string_extension.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_list_cubit.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';

class TodoTypeSelector extends StatelessWidget {
  const TodoTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoTypeCubit, String>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacing12,
            vertical: AppConstants.spacing8,
          ),
          child: SizedBox(
            width: context.screenWidth,
            height: context.screenHeight * 0.07,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final todoType = TodoType.values[index].name;
                return GestureDetector(
                  onTap: () {
                    context.read<TodoTypeCubit>().todoTypeSelected(todoType);
                    context.read<TodoListCubit>().fetchFilteredList(todoType);
                  },
                  child: Container(
                    width: context.screenWidth * 0.25,
                    height: context.screenHeight * 0.07,
                    decoration: BoxDecoration(
                      color: state == todoType
                          ? AppColors.primaryPurple
                          : AppColors.primaryGreen,
                      borderRadius: BorderRadius.circular(
                        AppConstants.radius16,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        todoType.toString().capitalizeFirst(),
                        style: context.textTheme.bodyLarge?.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                width: AppConstants.spacing16,
              ),
              itemCount: TodoType.values.length,
            ),
          ),
        );
      },
    );
  }
}
