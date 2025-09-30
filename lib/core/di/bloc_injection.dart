import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:smart_todo/features/home/presentation/cubit/todo_type_cubit.dart';

void registerBlocs() {
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc());

  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(authRepository: getIt<AuthRepository>()),
  );

  getIt.registerFactory<TodoTypeCubit>(() => TodoTypeCubit());
}
