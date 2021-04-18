import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repos/language_repo.dart';
import '../repos/post_repo.dart';
import '../utils/location_util.dart';

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
  var bgColorList = List<Color>().obs;
  var selectedBgColorIndex = 0.obs;
  var bgColor = Color(0xffffffff).obs;
  var currentPostLanguage = "English".obs;
  var languageList = List<String>().obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    bgColorList.assignAll(getColors());
    requestForLanguageList();
    super.onInit();
  }

  requestForCreatePost() async {
    var pref = GetStorage();

    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var response = await createPost(
        pref.read("userId"),
        postType.value,
        textEditingController.text.trim(),
        postType.value != "text"
            ? "#ffffff"
            : '#${bgColorList[selectedBgColorIndex.value].value.toRadixString(16).substring(2, 8)}',
        appliedTags.value,
        city.value,
        "",
        checkType(postVisibility.value),
        checkType(whoComment.value),
        isShareAllowed.value.toString(),
        isSaveAllowed.value.toString(),
        showInNearByChannel.value.toString(),
        "1");

    if (response.message == "User New Post Successfully Done.") {
      if (postType.value != "text") {
        await uploadPostFile(file.value, response.data.id, postType.value);
      }
      Get.back();
      textEditingController.text = "";
      city.value = "";
      appliedTags.value = "";
      postVisibility.value = 1;
      whoComment.value = 1;
      isShareAllowed.value = true;
      isSaveAllowed.value = true;
      showInNearByChannel.value = true;
      postType.value = "";
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

  List<Color> getColors() {
    return <Color>[
      Colors.grey.shade50,
      Colors.green,
      Colors.greenAccent,
      Colors.blueGrey,
      Colors.lightBlue,
      Colors.orange,
      Colors.deepOrange,
      Colors.deepOrangeAccent,
      Colors.indigo,
      Colors.purpleAccent,
      Colors.deepPurpleAccent,
      Colors.teal,
      Colors.pinkAccent,
      Colors.amber,
      Colors.brown
    ];
  }

  requestForLanguageList() async {
    var languages = await getLanguages();
    for (var item in languages) {
      languageList.add(item.name);
    }
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
