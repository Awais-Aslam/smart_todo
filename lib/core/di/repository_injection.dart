import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/home/data/datasources/notification_remote_data_source.dart';
import 'package:smart_todo/features/home/data/datasources/todo_remote_data_source.dart';
import 'package:smart_todo/features/home/data/repositories/notification_repository_impl.dart';
import 'package:smart_todo/features/home/data/repositories/todo_repository_impl.dart';
import 'package:smart_todo/features/home/domain/repositories/notification_repository.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';

void registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt<AuthRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      getIt<TodoRemoteDataSource>(),
    ),
  );

  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(
      getIt<NotificationRemoteDataSource>(),
    ),
  );
}
