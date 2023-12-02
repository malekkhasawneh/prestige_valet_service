import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> handleBackgroundMessage(RemoteMessage message)async {
    log('============================== title ${message.notification!.title}');
    log('============================== body ${message.notification!.body}');
    log('============================== payload ${message.data}');
  }

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log('============================== token $fcmToken');
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
