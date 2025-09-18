import 'package:firebase_auth/firebase_auth.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';

void registerDataSources() {
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt.get<FirebaseAuth>(),
    ),
  );
}
