import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  final FirebaseMessaging firebaseMessaging;

  NotificationService({
    required this.flutterLocalNotificationsPlugin,
    required this.firebaseMessaging,
  });

  // init local notifications
  Future<void> initLocalNotifications() async {
    // android settings
    const androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // ios settings
    const darwinInitializationSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    // init settings
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings,
    );

    // init plugin
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        // get the payload
        final payload = details.payload;

        // if payload empty return
        if (payload == null) return;

        // get notification
        final message = RemoteMessage.fromMap(jsonDecode(payload));

        // handle notification
        handleNotification(message);
      },
    );
  }

  // navigate user to notification screen
  void handleNotification(RemoteMessage? message) {}

  // notification details
  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_channel_id",
        "Daily Notifications",
        channelDescription: "Daily Notifications Channel",
        priority: Priority.high,
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  // init push notifications
  Future<void> initPushNotifications() async {
    // for ios specific foreground notifications
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // when the app is kill, and user taps on the notification
    await FirebaseMessaging.instance.getInitialMessage().then((message) {
      Future.delayed(
        const Duration(milliseconds: 300),
        () {
          handleNotification(message);
        },
      );
    });

    // when the app is in the background and user tap on the notification
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);

    // to handle silent notifications
    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);

    // show notification in the foreground
    FirebaseMessaging.onMessage.listen(
      (message) {
        final notification = message.notification;

        if (notification == null) return;

        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          notificationDetails(),
          payload: jsonEncode(message.toMap()),
        );
      },
    );
  }

  // init notifications
  Future<void> initNotifications() async {
    // request permissions
    await firebaseMessaging.requestPermission();

    // get fcm token
    final fcmToken = await firebaseMessaging.getToken();

    await initPushNotifications();

    await initLocalNotifications();

    debugPrint('FCM Token : $fcmToken');
  }
}

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  debugPrint("Title : ${message.notification?.title}");
  debugPrint("Body : ${message.notification?.body}");
  debugPrint("Payload : ${message.data}");
}
