part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class AddTodoSuccess extends TodoState {}

final class AddTodoError extends TodoState {
  final String message;

  AddTodoError(this.message);
}

final class FetchTodosSuccess extends TodoState {
  final List<TodoEntity> todoList;

  FetchTodosSuccess({required this.todoList});
}

final class FetchTodosError extends TodoState {
  final String message;

  FetchTodosError(this.message);
}
