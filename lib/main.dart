import 'package:chat_app_3/Modules/Views/Chat_Screen/Views/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Modules/Views/Home_Screen/Views/home_screen.dart';
import 'Modules/Views/Login_Screen/Views/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      getPages: [
        GetPage(name: '/', page: () => Login_Screen()),
        GetPage(name: '/home', page: () => Home_Screen()),
        GetPage(name: '/chat', page: () => Chat_Screen()),
      ],
    ),
  );
}
