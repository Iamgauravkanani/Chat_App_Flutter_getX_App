import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            (Auth_Helper.auth_helper.auth.currentUser?.photoURL == null)
                ? const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 90,
                    child: CircleAvatar(
                      radius: 80,
                      foregroundImage: NetworkImage(
                          "https://img.freepik.com/premium-photo/dog-suit-sunglasses-sits-chair_781958-1562.jpg"),
                    ),
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.orange,
                    child: CircleAvatar(
                      radius: 80,
                      foregroundImage: NetworkImage(
                          "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
                    ),
                  ),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
                ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                    ? Text("NAME: John Doe")
                    : Text(
                        "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
                : Text(
                    "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("EMAIL: JohnDoe@gmail.com")
                : Text(
                    "EMAIL: ${Auth_Helper.auth_helper.auth.currentUser?.email}"),
            const Divider(),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Auth_Helper.auth_helper.signOut();

                Get.offNamedUntil('/', (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
            ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("John Doe")
                : Text(
                    "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
            : Text("${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
        centerTitle: true,
      ),
    );
  }
}
