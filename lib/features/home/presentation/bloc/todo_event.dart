part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

final class AddTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final String category;
  final String priority;
  final String dueDate;

  AddTodoEvent({
    required this.category,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.title,
  });
}

final class EditTodoEvent extends TodoEvent {
  final String title;
  final String description;
  final String category;
  final String priority;
  final String dueDate;
  final String uid;

  EditTodoEvent({
    required this.category,
    required this.description,
    required this.dueDate,
    required this.priority,
    required this.title,
    required this.uid,
  });
}

final class DeleteTodoEvent extends TodoEvent {
  final String uid;

  DeleteTodoEvent({required this.uid});
}

final class FetchTodosEvent extends TodoEvent {}
