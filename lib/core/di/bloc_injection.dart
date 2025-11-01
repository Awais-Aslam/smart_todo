import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/services/secure_storage_service.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/home/domain/repositories/notification_repository.dart';
import 'package:smart_todo/features/home/domain/repositories/todo_repository.dart';
import 'package:smart_todo/features/home/presentation/bloc/todo_bloc.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_list_cubit.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';

void registerBlocs() {
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc());

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(
      authRepository: getIt<AuthRepository>(),
      storage: getIt<SecureStorageService>(),
    ),
  );

  getIt.registerFactory<TodoBloc>(
    () => TodoBloc(
      todoRepository: getIt<TodoRepository>(),
      notificationRepository: getIt<NotificationRepository>(),
    ),
  );

  getIt.registerFactory<TodoTypeCubit>(() => TodoTypeCubit());

  getIt.registerFactory<TodoListCubit>(
    () => TodoListCubit(
      todoRepository: getIt<TodoRepository>(),
    ),
  );
}
