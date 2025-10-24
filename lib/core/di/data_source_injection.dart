import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/network/dio_client.dart';
import 'package:smart_todo/core/network/rest_api_client.dart';
import 'package:smart_todo/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:smart_todo/features/home/data/datasources/notification_remote_data_source.dart';
import 'package:smart_todo/features/home/data/datasources/todo_remote_data_source.dart';

void registerDataSources() {
  getIt.registerLazySingleton<Dio>(() => DioClient().createDio());

  getIt.registerLazySingleton<RestApiClient>(
    () => RestApiClient(getIt<Dio>()),
  );

  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  getIt.registerLazySingleton<GoogleSignIn>(() => GoogleSignIn());

  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      getIt<FirebaseAuth>(),
      getIt<GoogleSignIn>(),
    ),
  );

  getIt.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      firebaseFirestore: FirebaseFirestore.instance,
      firebaseAuth: FirebaseAuth.instance,
    ),
  );

  getIt.registerLazySingleton<NotificationRemoteDataSource>(
    () => NotificationRemoteDataSourceImpl(
      getIt<RestApiClient>(),
    ),
  );
}
