import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../repos/language_repo.dart';
import '../repos/login_repo.dart';
import '../repos/register_repo.dart';
import '../views/multiple_language_selection_view.dart';
import '../views/pages.dart';

class LoginController extends GetxController {
  final pref = GetStorage();
  TextEditingController emailController;
  TextEditingController pwdController;
  GoogleSignIn _googleSignIn;
  var facebookSignIn;
  var languageList = List<String>().obs;
  var selectedLanguageByUser = "English".obs;

  @override
  void onInit() async {
    _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
    facebookSignIn = FacebookLogin();
    emailController = TextEditingController();
    pwdController = TextEditingController();
    await requestForLanguageList();
    selectedLanguageByUser.value = getLanguageFromPref();
    super.onInit();
  }

  requestForLoginProcess() async {
    bool status = false;

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);

    status = await loginProcess(emailController.text, pwdController.text);

    if (status) {
      Get.back();

      if (pref.hasData("isLanguageOptionShown") != true) {
        Get.offAll(MultipleLanguageSelView());
        pref.write("isDialogShown", true);
      } else
        Get.offAll(PagesScreen(
          currentIndex: 0,
        ));

      Get.snackbar("Success", "Login!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.greenAccent);
    } else {
      Get.back();
      Get.snackbar("Error", "Wrong Credentials. Please Check!",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent);
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
        var authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        var _user = authResult.user;
        assert(!_user.isAnonymous);
        assert(await _user.getIdToken() != null);

        await registerProcess(_user.phoneNumber, _user.email, _user.displayName,
            null, null, null, "gmail");

        pref.write("isLogin", true);
        Get.back();
        if (pref.hasData("isLanguageOptionShown") != true) {
          Get.offAll(MultipleLanguageSelView());
          pref.write("isDialogShown", true);
        } else
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
    pref.write("isLogin", true);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final FacebookAccessToken accessToken = result.accessToken;

        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final User _user =
            (await FirebaseAuth.instance.signInWithCredential(credential)).user;

        assert(!_user.isAnonymous);
        assert(await _user.getIdToken() != null);
        var response = await registerProcess(_user.phoneNumber, _user.email,
            _user.displayName, null, null, null, "facebook");

        // print('''
        //  Logged in!
        //
        //  Token: ${accessToken.token}
        //  User id: ${accessToken.userId}
        //  Expires: ${accessToken.expires}
        //  Permissions: ${accessToken.permissions}
        //  Declined permissions: ${accessToken.declinedPermissions}
        //  ''');

        Get.back();
        if (pref.hasData("isLanguageOptionShown") != true) {
          Get.offAll(MultipleLanguageSelView());
          pref.write("isDialogShown", true);
        } else
          Get.offAll(PagesScreen(
            currentIndex: 0,
          ));
        Get.snackbar("Success", "Login!", snackPosition: SnackPosition.BOTTOM);
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

  requestForLanguageList() async {
    var languages = await getLanguages();
    for (var item in languages) {
      languageList.add(item.name);
    }
  }

  changeLanguage(String languageItem) {
    selectedLanguageByUser.value = languageItem;
  }

  String getLanguageFromPref() {
    if (pref.hasData("languages") != true) {
      pref.write("languages", "English");
    }
    return pref.read("languages");
  }

  void setCurrentUser(String email, String name, String mobile,
      String profilePic, String userId, String city, String dob) {
    pref.write("isLogin", true);
    pref.write("name", name);
    pref.write("email", email);
    pref.write("mobile", mobile);
    pref.write("pic", profilePic);
    pref.write("userId", userId);
    pref.write("city", city);
    pref.write("dob", dob);
  }
}
