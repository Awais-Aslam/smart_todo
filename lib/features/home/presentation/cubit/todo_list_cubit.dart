import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_todo/core/extensions/list_extension.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';
import 'package:smart_todo/features/home/domain/usecases/fetch_todo.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_list_state.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';

class TodoListCubit extends Cubit<TodoListState> {
  final TodoRepository todoRepository;
  final FetchTodo fetchTodo;

  TodoListCubit({required this.todoRepository})
      : fetchTodo = FetchTodo(todoRepository),
        super(TodoListInitial());

  Future<void> fetchTodoList() async {
    final result = await fetchTodo();

    if (result.isSuccess) {
      final todos = result.data!;
      final sortedTodos = todos.sortByPriority();
      emit(TodoListLoaded(allTodos: sortedTodos, visibleTodos: sortedTodos));
    } else {
      emit(TodoListError(result.error!));
    }
  }

  void fetchFilteredList(String type) {
    if (state is! TodoListLoaded) return;

    final currentState = state as TodoListLoaded;
    final allTodos = currentState.allTodos;

    if (type == TodoType.all.name) {
      emit(TodoListLoaded(allTodos: allTodos, visibleTodos: allTodos));
    } else {
      final filtered = allTodos.where((todo) => todo.category == type).toList();
      final sortedTodos = filtered.sortByPriority();
      emit(TodoListLoaded(allTodos: allTodos, visibleTodos: sortedTodos));
    }
  }
}
