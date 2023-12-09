import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Utils/Constants/constant.dart';
import '../../../Utils/Helpers/Authentication_Helper/auth_helper.dart';
import '../Model/Sign_In_Model/sign_in_model.dart';
import '../Model/Sign_Up_Model/sign_up.dart';

class Login extends StatelessWidget {
  Login({super.key});
  GlobalKey<FormState> signKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController signup_email_con = TextEditingController();
  TextEditingController signup_password_con = TextEditingController();
  TextEditingController email_con = TextEditingController();
  TextEditingController password_con = TextEditingController();

  String? signup_email;
  String? signup_password;
  String? password;
  String? email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Image.asset("lib/Assets/Login_Screen_Assets/tct.png"),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: email_con,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "enter valid email";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        email = val;
                      },
                      decoration: const InputDecoration(
                        hintText: "enter email here..",
                        // border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: password_con,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "enter valid password";
                        } else {
                          return null;
                        }
                      },
                      onSaved: (val) {
                        password = val;
                      },
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "enter password here..",
                        // border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();

                    SignIn loginData =
                        SignIn(email: email!, password: password!);

                    Map<String, dynamic> res =
                        await Auth_Helper.auth_helper.signIn(data: loginData);

                    if (res['user'] != null) {
                      Get.offNamedUntil('/home', (routes) => false);
                    } else if (res['error'] != null) {
                      Get.snackbar("Flutter Chat App", "Login Failed");
                    }

                    email_con.clear();
                    password_con.clear();
                  }
                },
                child: Container(
                  height: 40,
                  width: 120,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Constant.appColor,
                  ),
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () async {
                  Get.defaultDialog(
                    title: "Chat App",
                    content: Form(
                      key: signKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter valid email";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              signup_email = val;
                            },
                            controller: signup_email_con,
                            decoration: const InputDecoration(
                              hintText: "enter email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Enter valid password";
                              } else {
                                return null;
                              }
                            },
                            onSaved: (val) {
                              signup_password = val;
                            },
                            controller: signup_password_con,
                            decoration: const InputDecoration(
                              hintText: "enter password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (signKey.currentState!.validate()) {
                                signKey.currentState!.save();

                                SignUp signup_detail = SignUp(
                                  email: signup_email!,
                                  password: signup_password!,
                                );

                                Map<String, dynamic> res = await Auth_Helper
                                    .auth_helper
                                    .signUp(data: signup_detail);

                                if (res['user'] != null) {
                                  // Get.snackbar("Chat App", "Signup Success");
                                  Get.back();
                                }
                              }

                              signup_email_con.clear();
                              signup_password_con.clear();
                            },
                            child: const Text("Sign Up"),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  "Sign up?",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () async {
                  Map res = await Auth_Helper.auth_helper.signInWithGoogle();
                  if (res['user'] != null) {
                    Get.offNamedUntil('/home', (routes) => false);
                  } else if (res['error'] != null) {
                    Get.snackbar("Flutter Chat App", "Login Failed");
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.transparent,
                  foregroundImage: AssetImage(
                    "lib/Assets/Login_Screen_Assets/google-logo-9825.png",
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
