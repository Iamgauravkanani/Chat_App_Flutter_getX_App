import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:chat_app_3/Modules/Views/Login_Screen/Model/Sign_Up_Model/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login_Screen extends StatelessWidget {
  Login_Screen({super.key});
  GlobalKey<FormState> signKey = GlobalKey<FormState>();
  TextEditingController signup_email_con = TextEditingController();
  TextEditingController signup_password_con = TextEditingController();

  String? signup_email;
  String? signup_password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Screen"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    "https://assets-v2.lottiefiles.com/a/aa6a52de-1186-11ee-8908-df4910d4b75e/MHf9ngGhBS.gif",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "enter email here..",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  hintText: "enter password here..",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Ink(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 5), color: Colors.grey, blurRadius: 5)
                  ],
                  color: Colors.blue,
                ),
                child: Container(
                  height: 40,
                  width: 180,
                  alignment: Alignment.center,
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () async {
                Map? res = await Auth_Helper.auth_helper.AnnoynimousLogin();

                if (res['user'] != null) {
                  Get.toNamed('/home');
                } else if (res['error'] != null) {
                  Get.snackbar("Flutter Chat App", "Login Failed");
                }
              },
              child: Ink(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ],
                  color: Colors.green,
                ),
                child: Container(
                  height: 40,
                  width: 180,
                  alignment: Alignment.center,
                  child: const Text(
                    "Annoynimous Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
                          decoration: InputDecoration(
                            hintText: "enter email",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
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
                          decoration: InputDecoration(
                            hintText: "enter password",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(
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
                          child: Text("Sign Up"),
                        ),
                      ],
                    ),
                  ),
                );
              },
              child: Ink(
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 5),
                      color: Colors.grey,
                      blurRadius: 5,
                    )
                  ],
                  color: Colors.orange,
                ),
                child: Container(
                  height: 40,
                  width: 180,
                  alignment: Alignment.center,
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
