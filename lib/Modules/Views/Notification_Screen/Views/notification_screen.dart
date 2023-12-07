import 'package:flutter/material.dart';

class Notification_Screen extends StatelessWidget {
  const Notification_Screen({super.key});

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
          ElevatedButton(onPressed: () {}, child: Text("Simple Notification")),
          ElevatedButton(
              onPressed: () {}, child: Text("Scheduled Notification")),
          ElevatedButton(
              onPressed: () {}, child: Text("Big Picture Notification")),
          ElevatedButton(
              onPressed: () {}, child: Text("Media Style Notification")),
        ],
      )),
    );
  }
}
