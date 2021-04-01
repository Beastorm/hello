import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hello/repos/login_repo.dart';
import 'package:hello/views/pages.dart';
import 'package:http/http.dart' as http;

class LoginController extends GetxController {
  TextEditingController emailController;
  TextEditingController pwdController;
  GoogleSignIn _googleSignIn;
  var facebookSignIn;

  @override
  void onInit() {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    facebookSignIn = FacebookLogin();

    emailController = TextEditingController();
    pwdController = TextEditingController();
    super.onInit();
  }

  requestForLoginProcess() async {
    bool status = false;

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    status = await loginProcess(emailController.text, pwdController.text);

    if (status) {
      Get.back();

      Get.offAll(PagesScreen(
        currentIndex: 0,
      ));
      Get.snackbar("Success", "Login!", snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.back();
      Get.snackbar("Error", "Something Went Wrong!",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> handleGoogleLoginIn() async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);
      var user = await _googleSignIn.signIn();

      if (user == null) {
        Get.back();
        return;
      } else {
        final googleAuth = await user.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        final pref = GetStorage();
        pref.write("isLogin", true);
        Get.back();
        Get.offAll(PagesScreen(
          currentIndex: 0,
        ));
        Get.snackbar("Success", "Login!", snackPosition: SnackPosition.BOTTOM);
      }
    } catch (error) {
      print(error);
    }
  }

  void logout() async {
    await _googleSignIn.disconnect();
    FirebaseAuth.instance.signOut();
  }

  handleFacebookLogin() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    final FacebookLoginResult result = await facebookSignIn.logIn(['email']);
    final pref = GetStorage();
    pref.write("isLogin", true);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        Get.back();
        Get.offAll(PagesScreen(
          currentIndex: 0,
        ));
        Get.snackbar("Success", "Login!", snackPosition: SnackPosition.BOTTOM);
        final FacebookAccessToken accessToken = result.accessToken;
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=first_name,picture&access_token=${accessToken.token}');
        final profile = jsonDecode(graphResponse.body);
        print(profile);

        print('''
         Logged in!
         
         Token: ${accessToken.token}
         User id: ${accessToken.userId}
         Expires: ${accessToken.expires}
         Permissions: ${accessToken.permissions}
         Declined permissions: ${accessToken.declinedPermissions}
         ''');

        break;
      case FacebookLoginStatus.cancelledByUser:
        print('Login cancelled by the user.');
        break;
      case FacebookLoginStatus.error:
        print('Something went wrong with the login process.\n'
            'Here\'s the error Facebook gave us: ${result.errorMessage}');
        break;
    }
  }
}
