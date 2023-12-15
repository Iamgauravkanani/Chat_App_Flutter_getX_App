import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../../Utils/Helpers/Authentication_Helper/auth_helper.dart';
import '../../../../Controller/Image_Picker_Controller/image_picker_controller.dart';

Drawer myDrawer() {
  ImagePicker picker = ImagePicker();
  ImagePickerController controller = Get.put(ImagePickerController());
  return Drawer(
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
            : Text("EMAIL: ${Auth_Helper.auth_helper.auth.currentUser?.email}"),
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
  );
}
