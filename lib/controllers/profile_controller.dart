import 'dart:io';

import 'package:Milto/common_components/MyAlertDilog.dart';
import 'package:Milto/common_components/MySnackBar.dart';
import 'package:Milto/models/ViewProfileModel.dart';
import 'package:Milto/views/LoginScreen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../repos/viewProfile_repo.dart';

class ProfileController extends GetxController {
  var isLoading = true.obs;
  final pref = GetStorage();
  String name;
  DataProfile profileData;
  var selectedImagePath = ''.obs;
  var selectedImageSize = ''.obs;

  @override
  void onInit() async{
    await requestForUserProfile();
    //await getUserProfileData();
    super.onInit();
  }

  @override
  void onReady() {
    //getUserProfileData();
    requestForUserProfile();
    super.onReady();
  }

   requestForUserProfile() async {
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
        if(response.personal.cover.isNotEmpty){
          pref.write('cover', response.personal.cover);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  void getImage(ImageSource imageSource) async {
    final pickedFile = await ImagePicker().getImage(source: imageSource);
    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
      selectedImageSize.value =
          ((File(selectedImagePath.value)).lengthSync() / 1024 / 1024)
              .toStringAsFixed(2) +
              'Mb';
    } else {
      MySnackbar.infoSnackBar('No Image selected', 'Please select an image');
    }
  }

  requestForAddCoverPhoto()async{
   MyAlertDialog.alertDialog('Cover photo updating..', '');
    var response = await addCoverPhoto(pref.read("userId"), selectedImagePath);

    // ignore: unrelated_type_equality_checks
   print('response....... $response');
    if(response.message=='Successfully Update Cover Picture.'){
      Get.back();
      MySnackbar.successSnackBar('Successful', 'Cover Image updated successfully');
    }else{
      Get.back();
      MySnackbar.errorSnackBar('Server Down', 'Server down please try again later');
    }
  }

  Future<DataProfile> getUserProfileData() async {
    try {
      isLoading(true);
      profileData = await viewProfile(pref.read("userId"));
      if (profileData != null) {
       name = profileData.personal.name;
       print('name ${profileData.personal.name}, namesing: $name');
       return profileData;
      }else{
        return profileData;
      }
    } finally {
      isLoading(false);
    }
  }

  logOut() async {
    if (pref.read("isLogin") == true) {
      await pref.erase();
      Get.offAll(() => LoginScreen());
    }
  }
}
