import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_todo/core/di/injection.dart';
import 'package:smart_todo/core/services/notification_service.dart';
import 'package:smart_todo/core/services/secure_storage_service.dart';

void registerServices() {
  getIt.registerLazySingleton<FlutterLocalNotificationsPlugin>(
    () => FlutterLocalNotificationsPlugin(),
  );

  getIt.registerLazySingleton<FirebaseMessaging>(
    () => FirebaseMessaging.instance,
  );

  getIt.registerLazySingleton<NotificationService>(
    () => NotificationService(
      flutterLocalNotificationsPlugin: getIt<FlutterLocalNotificationsPlugin>(),
      firebaseMessaging: getIt<FirebaseMessaging>(),
    ),
  );

  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
}
