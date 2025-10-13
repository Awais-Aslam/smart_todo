import 'package:smart_todo/core/domain/result.dart';
import 'package:smart_todo/core/domain/unit.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Result<Unit>> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  });
  Future<Result<List<TodoEntity>>> fetchTodos();
}
