import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../repos/register_repo.dart';
import '../views/LoginScreen.dart';

class RegisterController extends GetxController {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController mobileController;
  TextEditingController pwdController;
  TextEditingController cityController;

  // TextEditingController ageController;
  TextEditingController addressController;
  TextEditingController dobController;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    pwdController = TextEditingController();
    cityController = TextEditingController();
    dobController = TextEditingController();
    super.onInit();
  }

  requestForRegisterProcess() async {
    int status = -5;
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    status = await registerProcess(
      mobileController.text,
      emailController.text,
      nameController.text,
      pwdController.text,
      cityController.text,
      dobController.text,
    );

    if (status == 0) {
      Get.back();
      Get.offAll(LoginScreen());
      Get.snackbar(
        "Success",
        "Registered Successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else if (status == 1) {
      Get.back();
      Get.snackbar(
        "Error",
        "Already Registered",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      Get.back();
      Get.snackbar(
        "Error",
        "Something Went Wrong!",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
