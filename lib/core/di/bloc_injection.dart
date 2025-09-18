import 'package:smart_todo/core/app/locale/bloc/locale_bloc.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';
import 'package:smart_todo/features/auth/presentation/signup/bloc/signup_bloc.dart';

void registerBlocs() {
  getIt.registerFactory<LocaleBloc>(() => LocaleBloc());

  getIt.registerFactory<SignupBloc>(
    () => SignupBloc(authRepository: getIt<AuthRepository>()),
  );
}
