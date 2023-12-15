import 'package:chat_app_3/Modules/Views/Home_Screen/Controller/Tab_Controller/tab_controller.dart';
import 'package:chat_app_3/Modules/Views/Home_Screen/Views/Components/Tabs/ChatTab/chat_tab.dart';
import 'package:chat_app_3/Modules/Views/Home_Screen/Views/Components/Widgets/Drawer/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../Utils/Constants/constant.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TabsController tabsController = Get.put(TabsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: myDrawer(),
      appBar: AppBar(
        actions: [],
        backgroundColor: Constant.appColor,
        titleTextStyle: TextStyle(color: Constant.textcolor, fontSize: 22),
        title: Text("WhatsApp"),
        bottom: TabBar(
          labelStyle: TextStyle(fontSize: 18),
          dividerColor: Constant.textcolor,
          labelColor: Constant.textcolor,
          indicatorColor: Constant.textcolor,
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
