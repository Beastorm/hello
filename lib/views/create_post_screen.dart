import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/controllers/post_controller.dart';
import 'package:hello/style/AppColors.dart';
import 'package:hello/views/post_permission_screen.dart';
import 'package:hello/views/tag_screen.dart';
import 'package:video_player/video_player.dart';



class CreatePostScreenWidget extends StatefulWidget {
  final File file;
  final String postType;

  CreatePostScreenWidget({this.file, this.postType});

  @override
  _CreatePostScreenWidgetState createState() => _CreatePostScreenWidgetState();
}

class _CreatePostScreenWidgetState extends State<CreatePostScreenWidget> {
  final PostController postController = Get.put(PostController());

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.postType != "text") {
      postController.file.value = widget.file;
    }
    postController.postType.value = widget.postType;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            color: Colors.transparent,
            elevation: 0.0,
            child: Text(
              "Post",
              style: TextStyle(color: AppColors.themeColor, fontSize: 16.0),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                postController.requestForCreatePost();
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: postController.textEditingController,
                    validator: (input) =>
                        input.length < 5 ? "at least 5 characters" : null,
                    textInputAction: TextInputAction.newline,
                    keyboardType: TextInputType.multiline,
                    minLines: 5,
                    maxLines: 100,
                    style: TextStyle(
                        color: postController.bgColorList[postController
                                        .selectedBgColorIndex.value]
                                    .computeLuminance() >
                                0.5
                            ? Colors.black
                            : Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      fillColor: postController.bgColorList[
                          postController.selectedBgColorIndex.value],
                      hintText: 'What would you like to say?',
                      hintStyle: TextStyle(
                          color: postController.bgColorList[postController
                                          .selectedBgColorIndex.value]
                                      .computeLuminance() >
                                  0.5
                              ? Colors.black
                              : Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 32.0,
            ),
            GetX<PostController>(
              builder: (controller) {
                return controller.postType.value != ""
                    ? controller.postType?.value == "img"
                        ? Container(
                            child: Image.file(
                              controller.file.value,
                              fit: BoxFit.cover,
                              width: 140,
                              height: 180,
                            ),
                          )
                        : controller.postType?.value == "video"
                            ? Container(
                                height: 160,
                                alignment: Alignment.center,
                                child: Chewie(
                                  controller: ChewieController(
                                    videoPlayerController:
                                        VideoPlayerController.file(
                                            controller.file.value),
                                    aspectRatio: 4 / 4,
                                    autoInitialize: true,
                                    autoPlay: false,
                                    looping: false,
                                    errorBuilder: (context, errorMessage) {
                                      return Center(
                                        child: Text(
                                          errorMessage,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : controller.postType?.value == "text"
                                ? Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(4.0),
                                    child: Wrap(
                                      spacing: 4.0,
                                      runSpacing: 4.0,
                                      children: getColorWidget(controller),
                                    ),
                                  )
                                : SizedBox()
                    : SizedBox();
              },
            ),
            SizedBox(
              height: 32.0,
            ),
            GestureDetector(
              onTap: () {
                Get.to(TagScreenWidget());
              },
              child: Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                height: 56.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      "#",
                      style: TextStyle(color: Colors.pink, fontSize: 22.0),
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Topic",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Text(
                      "create /add Hash Tags",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            GestureDetector(
              onTap: () {
                postController.requestForCurrentLocation();
              },
              child: Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                height: 56.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    Icon(
                      Icons.add_location_sharp,
                      color: Colors.green,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Add location",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Container(
              color: Colors.grey.shade100,
              width: double.infinity,
              height: 56.0,
              child: Row(
                children: [
                  SizedBox(
                    width: 16.0,
                  ),
                  Text(
                    "@",
                    style: TextStyle(color: Colors.blueAccent, fontSize: 22.0),
                  ),
                  SizedBox(
                    width: 8.0,
                  ),
                  Text(
                    "Tag",
                    style: TextStyle(fontSize: 14.0),
                  ),
                  Spacer(),
                  Text(
                    "Tag your friends",
                    style: TextStyle(fontSize: 12.0, color: Colors.grey),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                    size: 20.0,
                  ),
                  SizedBox(
                    width: 16.0,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            GestureDetector(
              onTap: () {
                Get.to(PostPermissionScreenWidget());
              },
              child: Container(
                color: Colors.grey.shade100,
                width: double.infinity,
                height: 56.0,
                child: Row(
                  children: [
                    SizedBox(
                      width: 16.0,
                    ),
                    Icon(
                      Icons.settings_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Text(
                      "Post Permission",
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Spacer(),
                    Text(
                      "Public",
                      style: TextStyle(fontSize: 12.0, color: Colors.grey),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.grey,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 16.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> getColorWidget(PostController controller) {
    return List<Widget>.generate(
      controller.bgColorList.length,
      (int index) => GestureDetector(
        onTap: () {
          controller.selectedBgColorIndex.value = index;
        },
        child: Container(
          width: 48,
          height: 48,
          decoration: new BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(6.0)),
            color: controller.bgColorList[index],
            border: controller.selectedBgColorIndex.value == index
                ? Border.all(
                    color: Colors.black, width: 4.0, style: BorderStyle.solid)
                : Border.all(color: Colors.grey.withOpacity(0.5), width: 1.0),
          ),
        ),
      ),
    );
  }
}
