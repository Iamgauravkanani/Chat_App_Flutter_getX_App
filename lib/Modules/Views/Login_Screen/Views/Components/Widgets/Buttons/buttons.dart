import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../Utils/Constants/constant.dart';
import '../../../../../../Utils/Helpers/Authentication_Helper/auth_helper.dart';
import '../../../../Model/Sign_In_Model/sign_in_model.dart';
import '../../../../Model/Sign_Up_Model/sign_up.dart';

class Buttons {
  //Login Button
  static Builder loginButton() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () async {
          if (Constant.formKey.currentState!.validate()) {
            Constant.formKey.currentState!.save();

            SignIn loginData =
                SignIn(email: Constant.email!, password: Constant.password!);

            Map<String, dynamic> res =
                await Auth_Helper.auth_helper.signIn(data: loginData);

            if (res['user'] != null) {
              Get.offNamedUntil('/home', (routes) => false);
            } else if (res['error'] != null) {
              Get.snackbar("Flutter Chat App", "Login Failed");
            }

            Constant.email_con.clear();
            Constant.password_con.clear();
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
      );
    });
  }

  //Signup Button
  static InkWell signupButton() {
    return InkWell(
      onTap: () async {
        Get.defaultDialog(
          title: "Chat App",
          content: Form(
            key: Constant.signKey,
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
                    Constant.signup_email = val;
                  },
                  controller: Constant.signup_email_con,
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
                    Constant.signup_password = val;
                  },
                  controller: Constant.signup_password_con,
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
                    if (Constant.signKey.currentState!.validate()) {
                      Constant.signKey.currentState!.save();

                      SignUp signup_detail = SignUp(
                        email: Constant.signup_email!,
                        password: Constant.signup_password!,
                      );

                      Map<String, dynamic> res = await Auth_Helper.auth_helper
                          .signUp(data: signup_detail);

                      if (res['user'] != null) {
                        // Get.snackbar("Chat App", "Signup Success");
                        Get.back();
                      }
                    }

                    Constant.signup_email_con.clear();
                    Constant.signup_password_con.clear();
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
    );
  }

  //Google Signin Button
  static GestureDetector googleSigninButton() {
    return GestureDetector(
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
    );
  }
}
