import 'dart:io';

import 'package:get/get.dart';
import 'package:hello/models/view_response_model.dart';
import 'package:hello/repos/post_repo.dart';
import 'package:hello/views/create_post_screen.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var videoFile = File("").obs;
  var imageFile = File("").obs;
  ImagePicker picker = ImagePicker();
  PickedFile _pickedFile;
  var postList = List<Datum>().obs;

  @override
  void onInit() {
    super.onInit();
    requestALLPost();
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
    }
  }
}
