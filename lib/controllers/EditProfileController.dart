import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hello/repos/edit_profile_repo.dart';
import 'package:hello/views/profile_screen.dart';


class EditProfileController extends GetxController{
var box = GetStorage();
  TextEditingController nameController;
  TextEditingController mobileController;
  TextEditingController cityController;
  TextEditingController ageController;
  TextEditingController addressController;

  @override
  void onInit() {
    nameController = TextEditingController();
    mobileController = TextEditingController();
    cityController = TextEditingController();
    ageController = TextEditingController();
    addressController = TextEditingController();

    super.onInit();
  }

  requestForEditProfile() async {
    String id = box.read('userId');
    int status = -5;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    status = await editProfileProcess(
      id,
      nameController.text,
      nameController.text,
      cityController.text,
      ageController.text,
      addressController.text,
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
}