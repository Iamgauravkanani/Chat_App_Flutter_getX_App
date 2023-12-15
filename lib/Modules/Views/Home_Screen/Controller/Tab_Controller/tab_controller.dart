import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  List<Tab> tabs = <Tab>[
    Tab(
      child: Text("Chats"),
    ),
    Tab(
      child: Text("Status"),
    ),
    Tab(
      child: Text("Calls"),
    ),
  ];

  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(length: tabs.length, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
