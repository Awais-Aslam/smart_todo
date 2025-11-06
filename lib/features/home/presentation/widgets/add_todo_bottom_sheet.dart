import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_todo/core/constants/app_constants.dart';
import 'package:smart_todo/core/extensions/context_extension.dart';
import 'package:smart_todo/core/extensions/string_extension.dart';
import 'package:smart_todo/core/validators/validators.dart';
import 'package:smart_todo/core/widgets/app_button.dart';
import 'package:smart_todo/core/widgets/app_text_field.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';
import 'package:smart_todo/features/home/presentation/widgets/date_picker_dialog_widget.dart';

class AddTodoBottomSheet extends StatefulWidget {
  const AddTodoBottomSheet({
    super.key,
    required this.saveTodo,
    this.todo,
  });
  final Future<void> Function({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    String? uid,
  }) saveTodo;
  final TodoEntity? todo;

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dueDateController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String? formattedDate;
  String? category;
  String? priority;
  String? uid;

  Future<DateTime?> _selectDueDate() async {
    final results = await showDialog<List<DateTime?>>(
      context: context,
      builder: (context) => const DatePickerDialogWidget(),
    );

    return results?.first;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      setState(() {
        if (widget.todo != null) {
          titleController.text = widget.todo!.title;
          descriptionController.text = widget.todo!.description;
          category = widget.todo!.category;
          priority = widget.todo!.priority;

          formattedDate = DateFormat(AppConstants.dateFormatShort)
              .format(widget.todo!.dueDate.toDate());
          dueDateController.text = formattedDate ?? '';
          uid = widget.todo!.id;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppConstants.spacing16,
        right: AppConstants.spacing16,
        bottom: context.keyboardHeight,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppTextField(
                hintText: 'Title',
                controller: titleController,
                validator: Validators.validateTitle,
              ),
              const SizedBox(height: AppConstants.spacing16),
              AppTextField(
                hintText: 'Description',
                controller: descriptionController,
                validator: Validators.validateDescription,
              ),
              const SizedBox(height: AppConstants.spacing16),
              DropdownButtonFormField(
                value: category,
                items: TodoType.values.map((type) {
                  return DropdownMenuItem(
                    value: type.name,
                    child: Text(type.name.capitalizeFirst()),
                  );
                }).toList(),
                onChanged: (value) {
                  category = value;
                },
                hint: const Text('Category'),
                validator: Validators.validateCategory,
              ),
              const SizedBox(height: AppConstants.spacing16),
              DropdownButtonFormField(
                value: priority,
                items: TodoPriority.values.map((priority) {
                  return DropdownMenuItem(
                    value: priority.name,
                    child: Text(priority.name.capitalizeFirst()),
                  );
                }).toList(),
                onChanged: (value) {
                  priority = value;
                },
                hint: const Text('Priority'),
                validator: Validators.validatePriority,
              ),
              const SizedBox(height: AppConstants.spacing16),
              // date picker
              AppTextField(
                hintText: 'Due Date',
                controller: dueDateController,
                validator: Validators.validateDueDate,
                readOnly: true,
                onTap: () async {
                  final picked = await _selectDueDate();
                  if (picked != null) {
                    setState(() {
                      formattedDate = DateFormat(AppConstants.dateFormatShort)
                          .format(picked);
                      dueDateController.text = formattedDate!;
                    });
                  }
                },
              ),
              const SizedBox(height: AppConstants.spacing32),
              AppButton(
                onPressed: () {
                  context.hideKeyboard();
                  if (formKey.currentState!.validate()) {
                    widget.saveTodo(
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      priority: priority!,
                      category: category!,
                      dueDate: formattedDate!,
                      uid: uid,
                    );
                  }
                },
                title: widget.todo != null ? 'Edit' : 'Submit',
              ),
              const SizedBox(height: AppConstants.spacing64),
            ],
          ),
        ),
      ),
    );
  }
}
