import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../repos/edit_profile_repo.dart';
import '../views/profile_screen.dart';

class EditProfileController extends GetxController {
  var pref = GetStorage();
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController cityController;
  TextEditingController dobController;
  var file = File("").obs;
  var isFileSelected = false.obs;

  @override
  void onInit() {
    nameController = TextEditingController();
    mobileController = TextEditingController();
    cityController = TextEditingController();
    dobController = TextEditingController();

    nameController.text = pref.read("name");
    mobileController.text = pref.read("mobile");
    cityController.text = pref.read("city");
    dobController.text = pref.read("age");

    super.onInit();
  }

  requestForEditProfile() async {
    String id = pref.read('userId');
    int status = -5;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    status = await editProfileProcess(
      id,
      mobileController.text,
      nameController.text,
      dobController.text,
      cityController.text,
    );

    if (status == 0) {
      Get.back();
      Get.offAll(ProfileScreen());
      Get.snackbar(
        "Success",
        "Profile updated Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (status == 1) {
      Get.back();
      Get.snackbar(
        "Error",
        "Server down please try again",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.back();
      Get.snackbar(
        "Error",
        "Server down please try again",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  requestForImageUpload() async {
    final picker = ImagePicker();
    File _imageFile;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    _imageFile = File(pickedFile.path);
    file.value = _imageFile;
    isFileSelected(true);
    await editUserImage(file.value, pref.read("userId"));

    // await requestForUserAccount();
    update();
  }
}
