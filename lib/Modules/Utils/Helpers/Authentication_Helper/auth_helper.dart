import 'dart:ffi';

import 'package:chat_app_3/Modules/Views/Login_Screen/Model/Sign_In_Model/sign_in_model.dart';
import 'package:chat_app_3/Modules/Views/Login_Screen/Model/Sign_Up_Model/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth_Helper {
  //TODO:1=>Private Constructor
  Auth_Helper._();

  //TODO:2=>Singleton Object
  static final Auth_Helper auth_helper = Auth_Helper._();

  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();

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

  //TODO:SignUp

  Future<Map<String, dynamic>> signUp({required SignUp data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: data.email,
        password: data.password,
      );

      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  //TODO:SignIn

  Future<Map<String, dynamic>> signIn({required SignIn data}) async {
    Map<String, dynamic> res = {};
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: data.email, password: data.password);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  Future<Map<String, dynamic>> signInWithGoogle() async {
    Map<String, dynamic> res = {};
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredential =
          await auth.signInWithCredential(credential);
      res['user'] = userCredential.user;
    } on FirebaseAuthException catch (e) {
      res['error'] = e.code;
    }
    return res;
  }

  //TODO:Sign Out
  void signOut() async {
    await auth.signOut();
    await googleSignIn.signOut();
  }
}
