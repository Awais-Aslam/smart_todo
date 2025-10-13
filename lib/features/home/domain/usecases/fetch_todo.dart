import 'package:smart_todo/core/domain/result.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

class FetchTodo {
  final TodoRepository repository;

  FetchTodo(this.repository);

  Future<Result<List<TodoEntity>>> call() async {
    return await repository.fetchTodos();
  }
}
