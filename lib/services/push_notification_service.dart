import 'dart:io';

import 'package:connectnwork/repos/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

mixin LocalNotificationService {
  static Future<void> initialize() async {
    late AndroidNotificationChannel channel;

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    channel = const AndroidNotificationChannel(
      'connectnwork',
      'Connect&Work',
      importance: Importance.max,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    String? deviceIdToken = await messaging.getToken();

    if (deviceIdToken != null && FirebaseAuth.instance.currentUser != null) {
      await UserRepository.update(
        deviceId: deviceIdToken,
      );
    }
  }
}
