import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/tags_model.dart';
import '../repos/tag_repo.dart';

class TagController extends GetxController {
  var tagList = List<TagData>().obs;
  TextEditingController textEditingController;
  var selectedTags = List<TagData>().obs;
  var appliedTags = "".obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    requestForTags();
    super.onInit();
  }

  requestForTags() async {
    var dataList = await viewTags();
    tagList.assignAll(dataList);
    update();
  }

  requestForTagCreate() async {
    Get.dialog(Center(child: CircularProgressIndicator()),
        barrierDismissible: false);
    var response = await createTag(textEditingController.text.trim());

    if (response) {
      Get.back();
      textEditingController.text = "";
      await requestForTags();
      tagList.refresh();
      update();
      Get.snackbar("Post", "Created!", snackPosition: SnackPosition.BOTTOM);
    }

    update();
  }

  bool checkTag(TagData tag) {
    bool isFound = false;
    if (selectedTags.indexOf(tag) != -1) {
      isFound = true;
    } else {
      isFound = false;
    }
    print(isFound);

    update();
    selectedTags.refresh();
    return isFound;
  }

  addTagOrDeleteTag(TagData tag) {
    tagList.refresh();
    if (selectedTags.indexOf(tag) != -1) {
      selectedTags.remove(tag);
    } else {
      selectedTags.add(tag);
    }

    selectedTags.refresh();
    appliedTags.value = selectedTags.join(",");
    update();
  }
}
