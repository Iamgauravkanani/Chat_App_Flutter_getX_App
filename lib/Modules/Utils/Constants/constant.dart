import 'package:flutter/material.dart';

class Constant {
  static Color appColor = Color(0xff3AA984);

  //Login Screen Constants

  static GlobalKey<FormState> signKey = GlobalKey<FormState>();
  static TextEditingController signup_email_con = TextEditingController();
  static TextEditingController signup_password_con = TextEditingController();
  static String? signup_email;
  static String? signup_password;

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static TextEditingController email_con = TextEditingController();
  static TextEditingController password_con = TextEditingController();
  static String? password;
  static String? email;
}
