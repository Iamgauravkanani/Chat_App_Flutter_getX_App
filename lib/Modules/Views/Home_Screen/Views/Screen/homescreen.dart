import 'dart:developer';
import 'dart:io';
import 'package:chat_app_3/Modules/Views/Home_Screen/Controller/Tab_Controller/tab_controller.dart';
import 'package:chat_app_3/Modules/Views/Home_Screen/Views/Components/Tabs/ChatTab/chat_tab.dart';
import 'package:chat_app_3/Modules/Views/Home_Screen/Views/Components/Widgets/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../Utils/Helpers/Authentication_Helper/auth_helper.dart';
import '../../Controller/Image_Picker_Controller/image_picker_controller.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TabsController tabsController = Get.put(TabsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: mydrawer(),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text("WhatsApp"),
        bottom: TabBar(
          dividerColor: Colors.white,
          labelColor: Colors.white,
          indicatorColor: Colors.white,
          controller: tabsController.controller,
          tabs: tabsController.tabs,
        ),
      ),
      body: TabBarView(
        controller: tabsController.controller,
        children: [ChatTab(), ChatTab(), ChatTab()],
      ),
    );
  }
}
