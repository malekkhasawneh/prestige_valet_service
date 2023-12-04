import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingHelper {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fcmToken = await _firebaseMessaging.getToken();
    log('============================== fcm token $fcmToken');
  }
}
