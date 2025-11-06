import 'package:smart_todo/core/common/result.dart';
import 'package:smart_todo/core/common/unit.dart';
import 'package:smart_todo/features/home/data/datasources/todo_remote_data_source.dart';
import 'package:smart_todo/features/home/domain/entities/todo_entity.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoRemoteDataSource todoRemoteDataSource;

  TodoRepositoryImpl(this.todoRemoteDataSource);

  @override
  Future<Result<Unit>> addTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
  }) async {
    try {
      await todoRemoteDataSource.addTodo(
        title: title,
        description: description,
        category: category,
        priority: priority,
        dueDate: dueDate,
      );
      return Result.success(const Unit());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<TodoEntity>>> fetchTodos() async {
    try {
      final listTodo = await todoRemoteDataSource.fetchTodos();
      final List<TodoEntity> todoEntities =
          listTodo.map((todo) => todo.toEntity()).toList();

      return Result.success(todoEntities);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<Unit>> editTodo({
    required String title,
    required String description,
    required String category,
    required String priority,
    required String dueDate,
    required String uid,
  }) async {
    try {
      await todoRemoteDataSource.editTodo(
        title: title,
        description: description,
        category: category,
        priority: priority,
        dueDate: dueDate,
        uid: uid,
      );
      return Result.success(const Unit());
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
