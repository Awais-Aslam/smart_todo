import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';
import 'package:smart_todo/features/home/domain/usecases/add_todo.dart';
import 'package:smart_todo/features/home/domain/usecases/fetch_todo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  final AddTodo addTodo;
  final FetchTodo fetchTodo;

  TodoBloc({required this.todoRepository})
      : addTodo = AddTodo(todoRepository),
        fetchTodo = FetchTodo(todoRepository),
        super(TodoInitial()) {
    on<AddTodoEvent>(_addTodoEventHandler);
    on<FetchTodosEvent>(_fetchTodosEventHandler);
  }

  Future<void> _addTodoEventHandler(
    AddTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await addTodo(
      title: event.title,
      description: event.description,
      category: event.category,
      priority: event.priority,
      dueDate: event.dueDate,
    );

    if (result.isSuccess) {
      emit(AddTodoSuccess());
    } else {
      emit(AddTodoError(result.error!));
    }
  }

  Future<void> _fetchTodosEventHandler(
    FetchTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());

    final result = await fetchTodo();

    if (result.isSuccess) {
      emit(FetchTodosSuccess(todoList: result.data!));
    } else {
      emit(FetchTodosError(result.error!));
    }
  }
}
