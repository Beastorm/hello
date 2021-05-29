import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../common_components/MyAlertDilog.dart';
import '../models/comment_model.dart';
import '../models/follow_model.dart';
import '../models/language_model.dart';
import '../models/post_model.dart';
import '../repos/comment_repo.dart';
import '../repos/follow_repo.dart';
import '../repos/language_repo.dart';
import '../repos/post_repo.dart';
import '../repos/reaction_repo.dart';
import '../views/create_post_screen.dart';

class HomeController extends GetxController {
  final pref = GetStorage();
  Dio dio = Dio();
  var videoFile = File("").obs;
  var imageFile = File("").obs;
  ImagePicker picker = ImagePicker();
  PickedFile _pickedFile;
  var postList = List<PostData>().obs;
  TextEditingController commentContentController = TextEditingController();
  var currentUserPostList = List<PostData>().obs;
  var commentList = List<CommentData>().obs;

  List<LanguageData> languages;
  var languageList = List<String>().obs;
  var selectedLanguageByUser = "English".obs;

  var isLoading = true.obs;
  var commentFilter = List<CommentData>().obs;
  var commentReplyList = List<CommentData>().obs;
  var followedIds = List<String>().obs;

  //follow

  var followerList = List<FollowData>().obs; //followed
  var followingList = List<FollowData>().obs;

  var isFileDownloading = false.obs;
  var fileDownloadingPer = "0%".obs;

  var fileDownloadingStatus = "Downloading ...".obs;

  @override
  void onInit() async {
    super.onInit();
    await requestForLanguageList();
    selectedLanguageByUser.value = getLanguageFromPref();
    await requestALLPost();
    await requestForFollowerList();
  }

  requestALLPost() async {
    var posts = await viewPost();
    if (posts != null && posts.length > 0) {
      //   postList.assignAll(posts);
      postList.assignAll(posts
          .where((element) => element.language == getIdOfCurrentLanguage()));
      print("...................... ");
      print(getIdOfCurrentLanguage());
      print(postList);
      getCurrentUserPost(posts);
    }
  }

  // checking current user post
  getCurrentUserPost(posts) {
    if (posts.isNotEmpty)
      for (var item in posts) {
        if (item.user[0].id == pref.read("userId")) {
          currentUserPostList.add(item);
        }
      }
    print(currentUserPostList.length);
  }

  //FollowerList //followed
  requestForFollowerList() async {
    try {
      isLoading(true);
      var followers = await followerListApi(pref.read('userId'));

      if (followers != null) {
        followerList.assignAll(followers);
        getFollowedIds();
      }
      print('Followed:.... $followedIds');
    } finally {
      isLoading(false);
    }
  }

  //FollowingList
  requestForFollowingList() async {
    try {
      isLoading(true);
      var followings = await followingApi(pref.read('userId'));

      if (followings != null) {
        followingList.assignAll(followings);
      }
      print('Followings:.....$followings, list $followingList');
    } finally {
      isLoading(false);
    }
  }

  //-1-> not followed... should show follow
  //-0-> current user...should show nothing
  //-1-> followed... should show un follow

  getFollowedIds() {
    for (var item in followerList) {
      followedIds.add(item.userid[0].id);
    }
  }

  int checkFollowedUser(String userId) {
    if (followedIds.contains(userId)) {
      if (pref.read("userId") != userId) {
        return 1;
      } else
        return 0;
    }
    return -1;
  }

  requestForFollowUserProcess(String postUserId) async {
    if (!followedIds.contains(postUserId)) followedIds.add(postUserId);
    followedIds.refresh();
    postList.refresh();
    update();
    print('Followed:.... $followedIds');
    var response = await followAUser(postUserId, pref.read("userId"));

    print('Followed:.... $followedIds   $response');
  }

  requestForUnFollowUserProcess(String postUserId) async {
    if (followedIds.contains(postUserId)) followedIds.remove(postUserId);
    followedIds.refresh();
    postList.refresh();
    update();

    var response = await unFollowAUser(postUserId, pref.read("userId"));
    print('Followed:.... $followedIds   $response');
  }

  requestForSendComment(String postId, String parent) async {
    MyAlertDialog.alertDialog('Sending comment', '');
    var response = await sendComment(
        pref.read("userId"), parent, postId, commentContentController.text);
    commentContentController.clear();
    if (response == true) {
      Get.back();
    } else {
      Get.back();
    }
    print('response of send comment: $response');
  }

  requestForCommentListOfPost(String postId) async {
    // var commentFilter = List<CommentData>().obs;
    //var data = await getComments(postId);
    //     for(var item in data){
    //       if(item.id == "0"){
    //         commentFilter.add(item);
    //         continue;
    //       }
    try {
      isLoading(true);
      var data = await getComments(postId);
      if (data != null || data.length > 0) {
        // commentList.clear();
        commentList.assignAll(data);
        commentList.refresh();
        update();
      }
    } finally {
      isLoading(false);
    }
    commentFilter.clear();
    for (var item in commentList) {
      String parent = item.parent;
      if (parent == "0") {
        commentFilter.add(item);
        continue;
      }
    }
  }

  getCommentsReply(String commentId) async {
    print('Comments rply id: $commentId');
    commentReplyList.clear();
    for (var item in commentList) {
      String parentId = item.parent;
      if (commentId == parentId) {
        print('Parent id in loop: $parentId');
        commentReplyList.add(item);
      }
    }
    return commentReplyList;
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
    languages = await getLanguages();
    for (var item in languages) {
      languageList.add(item.name);
    }
  }

  changeLanguage(String languageItem) {
    selectedLanguageByUser.value = languageItem;
  }

  String getIdOfCurrentLanguage() {
    var currentLanguageTxt = pref.read("languages");
    LanguageData languageData =
        languages.firstWhere((element) => element.name == currentLanguageTxt);

    return languageData.id;
  }

  String getLanguageFromPref() {
    if (pref.hasData("languages") != true) {
      pref.write("languages", "English");
    }
    return pref.read("languages");
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

  @override
  void onClose() {
    super.onClose();
  }

  downloadFile(String url) async {
    var dir = await getExternalStorageDirectory();

    // Get.snackbar("Downloading", "$fileDownloadingPer}",
    //     backgroundColor: AppColors.themeColor,
    //     colorText: Colors.white,
    //     snackPosition: SnackPosition.BOTTOM,
    //     duration: Duration(days: 1));

    try {
      final status = await Permission.storage.request();

      if (status.isGranted)
        await dio.download(
            url, "${dir.path}/${url.substring(url.lastIndexOf("/") + 1)}",
            onReceiveProgress: (received, total) {
          isFileDownloading(true);

          fileDownloadingPer.value =
              (received / total * 100).toStringAsFixed(0) + "%";

          update();
          print((received / total * 100).toStringAsFixed(0) + "%");
          print(url.substring(url.lastIndexOf("/") + 1));
        });
    } on Exception catch (e) {
      print(e.toString());
    }

    isFileDownloading(false);
    fileDownloadingStatus.value = "Download Completed";
  }
}
