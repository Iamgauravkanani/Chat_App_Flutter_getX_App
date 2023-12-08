import 'dart:developer';

import 'package:flutter/material.dart';
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

  Future<void> showBigPictureNotification() async {
    var bigPictureStyleInformation = BigPictureStyleInformation(
      DrawableResourceAndroidBitmap("mipmap/messenger"),
      largeIcon: DrawableResourceAndroidBitmap("mipmap/messenger"),
      contentTitle: 'Apni Chat App',
      summaryText: 'Hello Big Picture Notification',
    );
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'big picture', 'big',
        styleInformation: bigPictureStyleInformation);
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0, 'big text title', 'silent body', platformChannelSpecifics,
        payload: "big image notifications");
  }

  Future<void> showNotificationMediaStyle() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'media channel id',
      'media channel',
      color: Colors.red,
      enableLights: true,
      largeIcon: DrawableResourceAndroidBitmap("mipmap/messenger"),
      styleInformation: MediaStyleInformation(),
    );
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
        0, 'Apni Chat App', 'Media Style', platformChannelSpecifics,
        payload: "Hello How Are You");
  }
}
