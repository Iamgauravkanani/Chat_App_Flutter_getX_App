import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';

class Auth_Helper {
  //TODO:1=>Private Constructor
  Auth_Helper._();

  //TODO:2=>Singleton Object
  static final Auth_Helper auth_helper = Auth_Helper._();

  FirebaseAuth auth = FirebaseAuth.instance;

  //TODO:Annoynimous Login

  Future<Map<String, dynamic>> AnnoynimousLogin() async {
    Map<String, dynamic> res = {};

    try {
      UserCredential credential = await auth.signInAnonymously();
      res['user'] = credential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }
}
