import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Auth_Helper.auth_helper.signOut();

                Get.offNamedUntil('/', (route) => false);
              },
              icon: Icon(Icons.logout))
        ],
        title: Text("Home Screen"),
        centerTitle: true,
      ),
    );
  }
}
