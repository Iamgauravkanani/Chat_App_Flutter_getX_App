import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.toNamed('/welcome');
    });
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("lib/Assets/Splash_Screen_Asset/screen.png"),
                fit: BoxFit.cover)),
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Container(
      //         height: 60,
      //         width: 60,
      //         decoration: BoxDecoration(
      //             image: DecorationImage(
      //                 image:
      //                     AssetImage("lib/Assets/Splash_Screen_Asset/logo.png"),
      //                 fit: BoxFit.cover)),
      //       ),
      //       SizedBox(
      //         height: 50,
      //       ),
      //       Text(
      //         "Apna Messenger 🇮🇳",
      //         style: GoogleFonts.getFont("Dhurjati").copyWith(
      //           fontWeight: FontWeight.w400,
      //           fontSize: 25,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
