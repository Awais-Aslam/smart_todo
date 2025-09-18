import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:smart_todo/features/auth/domain/repositories/auth_repository.dart';

void registerRepositories() {
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      getIt.get<AuthRemoteDataSource>(),
    ),
  );
}
