import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../style/AppColors.dart';
import '../views/pages.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pref = GetStorage();
    print("''''''''''''''''''");
    Timer(
        Duration(seconds: 5),
        () => pref.hasData("isLogin")
            ? Get.off(() => PagesScreen(
                  currentIndex: 0,
                ))
            : Get.off(LoginScreen()));

    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: AppColors.white,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 160.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: 160.0,
                  height: 160.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
