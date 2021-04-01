import 'dart:io';

import 'package:get/get.dart';
import 'package:hello/models/view_response_model.dart';
import 'package:hello/repos/post_repo.dart';
import 'package:hello/views/create_post_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var videoFile = File("").obs;
  var imageFile = File("").obs;

  var postList = List<Datum>().obs;

  @override
  void onInit() {
    super.onInit();
    requestALLPost();
  }

  pickVideoFromGallery() async {
    final picker = ImagePicker();
    File _videoFile;
    var pickedFile = await picker.getVideo(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    _videoFile = File(pickedFile.path);
    videoFile.value = _videoFile;
    Get.to(
        () => CreatePostScreenWidget(file: videoFile.value, fileType: "video"));
    update();
  }

  pickImageFromGallery() async {
    final picker = ImagePicker();
    File _imageFile;
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile == null) {
      return;
    }
    _imageFile = File(pickedFile.path);
    imageFile.value = _imageFile;
    print(_imageFile.path);
    Get.to(
        () => CreatePostScreenWidget(file: imageFile.value, fileType: "img"));
    update();
  }

  requestALLPost() async {
    // Get.dialog(Center(child: CircularProgressIndicator()),
    //     barrierDismissible: false);
    var posts = await viewPost();
    if (posts != null) {
      /// Get.back();
      postList.assignAll(posts);
    }
  }
}
