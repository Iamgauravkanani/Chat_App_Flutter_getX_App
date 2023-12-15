import 'package:chat_app_3/Modules/Views/Home_Screen/Controller/Tab_Controller/tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  TabsController tabsController = Get.put(TabsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: tabsController.controller,
          tabs: tabsController.tabs,
        ),
      ),
    );
  }
}
