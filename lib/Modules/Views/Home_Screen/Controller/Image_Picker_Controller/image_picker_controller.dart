import 'dart:io';

import 'package:chat_app_3/Modules/Views/Home_Screen/Model/Image_Picker_Model/image_picker_model.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  ImagePickerModel imagePickerModel = ImagePickerModel();

  void pickImage({required File pickedImage}) {
    imagePickerModel.image = pickedImage;
    update();
  }
}
