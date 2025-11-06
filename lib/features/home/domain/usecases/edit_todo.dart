import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

class EditTodo {
  final TodoRepository repository;

  EditTodo(this.repository);

  Future<Result<Unit>> call({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    required String uid,
  }) async {
    return await repository.editTodo(
      title: title,
      description: description,
      category: category,
      priority: priority,
      dueDate: dueDate,
      uid: uid,
    );
  }
}
