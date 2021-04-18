import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../common_components/langugae_dialog.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../repos/comment_repo.dart';
import '../repos/language_repo.dart';
import '../repos/post_repo.dart';
import '../repos/reaction_repo.dart';
import '../views/create_post_screen.dart';

class HomeController extends GetxController {
  final pref = GetStorage();
  var videoFile = File("").obs;
  var imageFile = File("").obs;
  ImagePicker picker = ImagePicker();
  PickedFile _pickedFile;
  var postList = List<PostData>().obs;
  TextEditingController commentContentController = TextEditingController();
  var currentUserPostList = List<PostData>().obs;
  var commentList = List<CommentData>().obs;

  var languageList = List<String>().obs;
  var selectedLanguagesByUser = List<String>().obs;

  @override
  void onInit() async {
    super.onInit();
    await requestALLPost();
    await requestForLanguageList();

    if (pref.hasData("isDialogShown") != true) {
      await languageDialog(true);
      pref.write("isDialogShown", true);
    }

    selectedLanguagesByUser.assignAll(stringToList());
  }

  pickVideoFromGallery() async {
    File _videoFile;
    _pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (_pickedFile == null) {
      return;
    }
    _videoFile = File(_pickedFile.path);
    videoFile.value = _videoFile;
    Get.off(
        () => CreatePostScreenWidget(file: videoFile.value, postType: "video"));
    update();
  }

  pickImageFromGallery() async {
    File _imageFile;
    _pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (_pickedFile == null) {
      return;
    }
    _imageFile = File(_pickedFile.path);
    imageFile.value = _imageFile;
    print(_imageFile.path);
    Get.off(
        () => CreatePostScreenWidget(file: imageFile.value, postType: "img"));
    update();
  }

  createTextPost() {
    Get.off(() => CreatePostScreenWidget(file: null, postType: "text"));
    update();
  }

  requestALLPost() async {
    // Get.dialog(Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    var posts = await viewPost();
    if (posts != null) {
      /// Get.back();
      postList.assignAll(posts);
      getCurrentUserPost(posts);
    }
  }

  getCurrentUserPost(posts) {
    if (posts.isNotEmpty)
      for (var item in posts) {
        if (item.user[0].id == pref.read("userId")) {
          currentUserPostList.add(item);
        }
      }
    print(currentUserPostList.length);
  }

  requestForSendComment(String postId, String parent) async {
    await sendComment(
        pref.read("userId"), "0", postId, commentContentController.text);
    commentContentController.clear();
  }

  requestForCommentListOfPost(String postId) async {
    var data = await getComments(postId);
    if (data != null || data.length > 0) {
      commentList.clear();
      commentList.assignAll(data);
      commentList.refresh();
    }
  }

  // send reaction of current user of a post
  requestForToSendReaction(String postId, String reactionId) async {
    print("................");
    print(postId);
    print(reactionId);
    print(pref.read("userId"));
    await sendReaction(pref.read("userId"), reactionId, postId);
  }

  // here we are checking reaction of current user of a post
  String checkCurrentUserReaction(List<PostReaction> postReactions) {
    if (postReactions.isNotEmpty) {
      for (var item in postReactions)
        if (item.user == pref.read("userId")) {
          return getReactionList()[item.reaction];
        }
    }

    return getReactionList()["-1"];
  }

  Map<String, String> getReactionList() {
    return {
      "-1": "",
      "1": " ",
      "2": "assets/images/happy.svg",
      "3": "assets/images/love.svg",
      "4": "assets/images/sad.svg",
      "5": "assets/images/angry.svg",
    };
  }

  requestForLanguageList() async {
    var languages = await getLanguages();
    for (var item in languages) {
      languageList.add(item.name);
    }
  }

  bool checkLanguage(String languageItem) {
    bool isFound = false;
    if (selectedLanguagesByUser.indexOf(languageItem) != -1) {
      isFound = true;
    } else {
      isFound = false;
    }
    print(isFound);

    update();
    selectedLanguagesByUser.refresh();
    return isFound;
  }

  addLanguageOrDeleteLanguage(String languageItem) {
    languageList.refresh();
    if (selectedLanguagesByUser.indexOf(languageItem) != -1) {
      selectedLanguagesByUser.remove(languageItem);
    } else {
      selectedLanguagesByUser.add(languageItem);
    }

    selectedLanguagesByUser.refresh();
    pref.write("languages", selectedLanguagesByUser.join(","));
    print("......................");
    print(selectedLanguagesByUser.join(","));
    update();
  }

  List<String> stringToList() {
    if (pref.read("languages") != "") {
      return pref.read("languages").split(",");
    }
    return ["English"];
  }
}
