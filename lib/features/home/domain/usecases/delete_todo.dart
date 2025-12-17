import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository repository;

  DeleteTodoUsecase(this.repository);

  Future<Result<Unit>> call({required String uid}) async =>
      await repository.deleteTodo(uid: uid);
}
