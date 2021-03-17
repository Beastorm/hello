import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  TextEditingController nameController;
  TextEditingController emailController;
  TextEditingController mobileController;
  TextEditingController pwdController;

  @override
  void onInit() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    mobileController = TextEditingController();
    pwdController = TextEditingController();

    super.onInit();
  }
}
