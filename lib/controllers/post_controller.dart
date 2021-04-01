import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hello/repos/post_repo.dart';
import 'package:hello/utils/location_util.dart';

class PostController extends GetxController {
  TextEditingController textEditingController;

  var postType = "".obs;
  var file = File("").obs;
  var city = "".obs;
  var appliedTags = "".obs;
  var postVisibility = 1.obs;
  var whoComment = 1.obs;
  var isShareAllowed = true.obs;
  var isSaveAllowed = true.obs;
  var showInNearByChannel = true.obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();

    super.onInit();
  }

  requestForCreatePost() async {
    var pref = GetStorage();

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var response = await createPost(
        pref.read("userId"),
        "text",
        textEditingController.text.trim(),
        "#ffffff",
        appliedTags.value,
        city.value,
        "",
        checkType(postVisibility.value),
        checkType(whoComment.value),
        isShareAllowed.value.toString(),
        isSaveAllowed.value.toString(),
        showInNearByChannel.value.toString(),
        "1");
    if (response) {
      Get.back();
      textEditingController.text = "";
      city.value = "";
      appliedTags.value = "";
      postVisibility.value = 1;
      whoComment.value = 1;
      isShareAllowed.value = true;
      isSaveAllowed.value = true;
      showInNearByChannel.value = true;

      update();
      Get.snackbar("Post", "Created!", snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  requestForCurrentLocation() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var data = await getUserCurrentAddress();
    city.value = data;
    update();
    Get.back();
  }

  String checkType(int type) {
    switch (type) {
      case 1:
        return "Public";

      case 2:
        return "Friends";

      case 3:
        return "Only me";
    }
    return "Public";
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
