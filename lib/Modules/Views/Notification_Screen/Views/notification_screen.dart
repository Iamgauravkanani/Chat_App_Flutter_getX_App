import 'dart:developer';

import 'package:chat_app_3/Modules/Utils/Helpers/Notification_Helper/notification_helper.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class Notification_Screen extends StatefulWidget {
  const Notification_Screen({super.key});

  @override
  State<Notification_Screen> createState() => _Notification_ScreenState();
}

class _Notification_ScreenState extends State<Notification_Screen> {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  getFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    log("${token}");
    return token;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Notification_Helper.notification_helper.initNotification();
    getFCMToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification Screen"),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Notification_Helper.notification_helper
                    .showSimpleNotification();
              },
              child: Text("Simple Notification")),
          ElevatedButton(
              onPressed: () {}, child: Text("Scheduled Notification")),
          ElevatedButton(
              onPressed: () {
                Notification_Helper.notification_helper
                    .showBigPictureNotification();
              },
              child: Text("Big Picture Notification")),
          ElevatedButton(
              onPressed: () {
                Notification_Helper.notification_helper
                    .showNotificationMediaStyle();
              },
              child: Text("Media Style Notification")),
        ],
      )),
    );
  }
}
