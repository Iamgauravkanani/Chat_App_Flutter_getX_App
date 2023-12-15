import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Utils/Constants/constant.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("lib/Assets/Welcome_Screen_Assets/welcome.png"),
            Image.asset("lib/Assets/Welcome_Screen_Assets/barcode.png"),
            Image.asset("lib/Assets/Welcome_Screen_Assets/privacypolicy.png"),
            GestureDetector(
              onTap: () {
                Get.toNamed('/login');
              },
              child: Container(
                height: 50,
                width: 320,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Constant.appColor,
                ),
                child: Text(
                  "Agree and Continue",
                  style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            Column(
              children: [
                Text(
                  "from",
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  "FACEBOOK",
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
