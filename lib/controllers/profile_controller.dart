import 'package:Milto/models/ViewProfileModel.dart';
import 'package:Milto/views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repos/viewProfile_repo.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  final pref = GetStorage();

  @override
  void onInit() {
    requestForUserProfile();
    super.onInit();
  }

  @override
  void onReady() {
    requestForUserProfile();
    super.onReady();
  }

  void requestForUserProfile() async {
    try {
      isLoading(true);
      DataProfile response = await viewProfile(pref.read("userId"));
      if (response != null) {
        if (response.personal.image.isNotEmpty) {
          pref.write("pic", response.personal.image);
        }
        if (response.personal.name.isNotEmpty) {
          pref.write("name", response.personal.name);
        }
        if (response.personal.email.isNotEmpty) {
          pref.write("email", response.personal.email);
        }
        if (response.personal.mobile.isNotEmpty) {
          pref.write("mobile", response.personal.mobile);
        }
        if (response.personal.address.isNotEmpty) {
          pref.write("city", response.personal.address);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  logOut() async {
    if (pref.read("isLogin") == true) {
      await pref.remove("isLogin");
      Get.offAll(() => LoginScreen());
    }
  }
}
