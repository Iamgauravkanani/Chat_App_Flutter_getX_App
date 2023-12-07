import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notification_Helper {
  Notification_Helper._();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static final Notification_Helper notification_helper =
      Notification_Helper._();

  void initNotification() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/messenger');
    var initializationSettingsIOs = DarwinInitializationSettings();
    var initSetttings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOs);

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onDidReceiveNotificationResponse: (NotificationResponse responce) {
      log("====================================================================");
      log("${responce.payload}");
      log("====================================================================");
    });
  }

  void showSimpleNotification() async {
    var android = AndroidNotificationDetails('id', 'Simple Notification ',
        priority: Priority.high, importance: Importance.max);
    var iOS = DarwinNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(
        0, 'Apni Chat App', 'Hey How Are You', platform,
        payload: 'Hello I am Flutter Developer');
  }
}
