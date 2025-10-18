import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<Result<Unit>> call({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  }) async {
    return await repository.addTodo(
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
    );
  }
}
