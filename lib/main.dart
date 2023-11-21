import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Modules/Views/Login_Screen/Views/login_screen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: () => Login_Screen()),
      ],
    ),
  );
}
