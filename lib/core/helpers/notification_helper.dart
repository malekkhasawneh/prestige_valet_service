import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:prestige_valet_app/core/resources/constants.dart';

class NotificationHelper {
  static Future<void> init() async {
    await AwesomeNotifications().initialize('', [
      NotificationChannel(
          channelKey: Constants.baseNotificationChannelKey,
          channelName: Constants.baseNotificationChannelName,
          channelDescription: Constants.baseNotificationChannelDesc,
          playSound: true,
          onlyAlertOnce: true,
          groupAlertBehavior: GroupAlertBehavior.Children,
          importance: NotificationImportance.High,
          defaultPrivacy: NotificationPrivacy.Private,
          defaultColor: Colors.deepPurple,
          ledColor: Colors.deepPurple)
    ]);
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  static Future<void> sendLocalNotification({
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: Constants.baseNotificationChannelKey,
        actionType: ActionType.Default,
        title: title,
        body: body,
        notificationLayout: NotificationLayout.BigText,
      ),
    );
  }
}
