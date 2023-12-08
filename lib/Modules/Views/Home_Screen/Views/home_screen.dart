import 'dart:developer';
import 'dart:io';

import 'package:chat_app_3/Modules/Utils/Helpers/Authentication_Helper/auth_helper.dart';
import 'package:chat_app_3/Modules/Utils/Helpers/Cloud_FireStore_Helper/cloud_firestore_helper.dart';
import 'package:chat_app_3/Modules/Utils/Stream/stream.dart';
import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Chat_Model/chat_model.dart';
import 'package:chat_app_3/Modules/Views/Chat_Screen/Model/Receiver_Details_Model/receiver_details_model.dart';
import 'package:chat_app_3/Modules/Views/Home_Screen/Controller/Image_Picker_Controller/image_picker_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class Home_Screen extends StatelessWidget {
  Home_Screen({super.key});

  ImagePicker picker = ImagePicker();

  ImagePickerController controller = Get.put(ImagePickerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            (Auth_Helper.auth_helper.auth.currentUser?.photoURL == null)
                ? const CircleAvatar(
                    backgroundColor: Colors.red,
                    radius: 90,
                    child: CircleAvatar(
                      radius: 85,
                      foregroundImage: NetworkImage(
                          "https://img.freepik.com/premium-photo/dog-suit-sunglasses-sits-chair_781958-1562.jpg"),
                    ),
                  )
                : CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.orange,
                    child: CircleAvatar(
                      radius: 85,
                      foregroundImage: NetworkImage(
                          "${Auth_Helper.auth_helper.auth.currentUser?.photoURL}"),
                    ),
                  ),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
                ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                    ? Text("NAME: John Doe")
                    : Text(
                        "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
                : Text(
                    "NAME: ${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
            const Divider(),
            (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("EMAIL: JohnDoe@gmail.com")
                : Text(
                    "EMAIL: ${Auth_Helper.auth_helper.auth.currentUser?.email}"),
            const Divider(),
            GestureDetector(
                onTap: () {
                  Get.defaultDialog(
                      title: "Choose Image From...",
                      content: Container(
                        height: 100,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GetBuilder<ImagePickerController>(
                              builder: (controller) => IconButton(
                                  onPressed: () async {
                                    XFile? photo = await picker.pickImage(
                                        source: ImageSource.camera);

                                    controller.pickImage(
                                        pickedImage: File(photo!.path));
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 35,
                                  )),
                            ),
                            GetBuilder<ImagePickerController>(
                              builder: (controller) => IconButton(
                                  onPressed: () async {
                                    XFile? photo = await picker.pickImage(
                                        source: ImageSource.gallery);

                                    controller.pickImage(
                                        pickedImage: File(photo!.path));
                                    log("${controller.imagePickerModel.image?.path}");
                                    Get.back();
                                  },
                                  icon: Icon(
                                    Icons.photo,
                                    size: 35,
                                  )),
                            )
                          ],
                        ),
                      ));
                },
                child: (controller.imagePickerModel.image == null)
                    ? CircleAvatar(
                        radius: 80,
                      )
                    : GetBuilder<ImagePickerController>(
                        builder: (_) => CircleAvatar(
                          radius: 80,
                          foregroundImage:
                              FileImage(controller.imagePickerModel.image!),
                        ),
                      )),
          ],
        ),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                Get.toNamed('/notification');
              },
              icon: Icon(Icons.notifications_outlined)),
          IconButton(
              onPressed: () {
                Auth_Helper.auth_helper.signOut();

                Get.offNamedUntil('/', (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
        title: (Auth_Helper.auth_helper.auth.currentUser?.displayName == null)
            ? (Auth_Helper.auth_helper.auth.currentUser?.email == null)
                ? Text("John Doe")
                : Text(
                    "${Auth_Helper.auth_helper.auth.currentUser?.email?.split("@")[0]}")
            : Text("${Auth_Helper.auth_helper.auth.currentUser?.displayName}"),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: Firestore_Helper.firestore_helper.fetchUser(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          } else if (snapshot.hasData) {
            QuerySnapshot<Map<String, dynamic>>? querySnapshot = snapshot.data;
            List<QueryDocumentSnapshot<Map<String, dynamic>>>? userData =
                querySnapshot?.docs;

            return ListView.builder(
                itemCount: userData?.length,
                itemBuilder: (ctx, i) {
                  return Card(
                      elevation: 3,
                      child: ListTile(
                        onTap: () async {
                          Receiver receiver = Receiver(
                              name: userData?[i]['name'],
                              uid: userData?[i]['uid'],
                              photo: userData?[i]['photo']);

                          ChatDetails chatdata = ChatDetails(
                              receiverUid: receiver.uid,
                              senderUid:
                                  Auth_Helper.auth_helper.auth.currentUser!.uid,
                              message: "");
                          messageData = await Firestore_Helper.firestore_helper
                              .displayMessage(chatDetails: chatdata);
                          Get.toNamed("/chat", arguments: receiver);
                        },
                        title: Text("${userData?[i]['name']}"),
                        subtitle: Text("${userData?[i]['email']}"),
                        leading: CircleAvatar(
                          radius: 30,
                          foregroundImage:
                              NetworkImage("${userData?[i]['photo']}"),
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            Firestore_Helper.firestore_helper.deleteUser(
                                deleteData: "${userData?[i]['uid']}");
                          },
                          icon: Icon(Icons.delete_outline),
                        ),
                      ));
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
