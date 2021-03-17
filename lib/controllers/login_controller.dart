import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  TextEditingController emailController;
  TextEditingController pwdController;

  @override
  void onInit() {
    emailController = TextEditingController();
    pwdController = TextEditingController();
    super.onInit();
  }
}
