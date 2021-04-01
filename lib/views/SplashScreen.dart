import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hello/views/pages.dart';

import '../style/AppColors.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pref = GetStorage();
    print("''''''''''''''''''");
    Timer(
        Duration(seconds: 5),
        () => pref.hasData("isLogin")
            ? Get.to(() => PagesScreen(
                currentIndex: 0,
              ))
            : Get.to(LoginScreen()));

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
