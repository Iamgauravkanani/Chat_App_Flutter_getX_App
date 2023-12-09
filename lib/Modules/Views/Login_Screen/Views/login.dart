import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Enter Your Email ID",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
              ),
              Image.asset("lib/Assets/Login_Screen_Assets/dots.jpg")
            ],
          )
        ],
      ),
    );
  }
}
