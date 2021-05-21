import 'package:Milto/models/ViewProfileModel.dart';
import 'package:Milto/views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repos/viewProfile_repo.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  final pref = GetStorage();
  var profileData = DataProfile();
  String name;

  @override
  void onInit() {
    //getUserProfileData();
    requestForUserProfile();
    super.onInit();
  }

  @override
  void onReady() {
    //getUserProfileData();
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
          name = response.personal.name;
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

  // getUserProfileData() async {
  //   try {
  //     isLoading(true);
  //     DataProfile profileData = await viewProfile(pref.read("userId"));
  //     if (profileData != null) {
  //      name = profileData.personal.name;
  //      print('name ${profileData.personal.name}, namesing: $name');
  //     }
  //   } finally {
  //     isLoading(false);
  //   }
  // }

  logOut() async {
    if (pref.read("isLogin") == true) {
      await pref.erase();
      Get.offAll(() => LoginScreen());
    }
  }
}
