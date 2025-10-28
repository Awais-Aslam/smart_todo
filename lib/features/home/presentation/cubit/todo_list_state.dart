import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';

abstract class TodoListState {}

class TodoListInitial extends TodoListState {}

class TodoListLoading extends TodoListState {}

class TodoListLoaded extends TodoListState {
  final List<TodoEntity> allTodos;
  final List<TodoEntity> visibleTodos;

  TodoListLoaded({
    required this.allTodos,
    required this.visibleTodos,
  });
}

class TodoListError extends TodoListState {
  final String message;

  TodoListError(this.message);
}
