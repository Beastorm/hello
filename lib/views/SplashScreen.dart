import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../style/AppColors.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () {
      Get.offAll(LoginScreen());
      // if (loginStatus == 'true') {
      //   Get.offAll(HomeScreen());
      // } else {
      //   Get.offAll(LoginScreen());
      // }
    });

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 120.0,
              height: 110.0,
            ),
          ],
        )),
      ),
    );
  }
}
