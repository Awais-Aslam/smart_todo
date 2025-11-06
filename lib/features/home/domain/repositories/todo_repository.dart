import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<Result<Unit>> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  });
  Future<Result<Unit>> editTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    required String uid,
  });

  Future<Result<List<TodoEntity>>> fetchTodos();
}
