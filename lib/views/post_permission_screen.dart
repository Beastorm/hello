import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:hello/controllers/post_controller.dart';
import 'package:hello/style/AppColors.dart';

class PostPermissionScreenWidget extends StatelessWidget {
  final PostController _postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Post Permissions",
          style: TextStyle(color: Colors.grey),
        ),
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
      ),
      body: SafeArea(
        child: Obx(
          () => ListView(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Who can see my post?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RadioListTile(
                      title: Text("Public"),
                      value: 1,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.postVisibility.value,
                      selected: _postController.postVisibility.value == 1,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.postVisibility.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile(
                      title: Text("Friends"),
                      value: 2,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.postVisibility.value,
                      selected: _postController.postVisibility.value == 2,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.postVisibility.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile(
                      title: Text("Only me"),
                      value: 3,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.postVisibility.value,
                      selected: _postController.postVisibility.value == 3,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.postVisibility.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 12,
                color: Colors.grey.shade200,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Who can comment on my post?",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    RadioListTile(
                      title: Text("Public"),
                      value: 1,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.whoComment.value,
                      selected: _postController.whoComment.value == 1,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.whoComment.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile(
                      title: Text("Friends"),
                      value: 2,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.whoComment.value,
                      selected: _postController.whoComment.value == 2,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.whoComment.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    ),
                    RadioListTile(
                      title: Text("Only me"),
                      value: 3,
                      activeColor: AppColors.themeColor,
                      groupValue: _postController.whoComment.value,
                      selected: _postController.whoComment.value == 3,
                      toggleable: true,
                      onChanged: (value) {
                        _postController.whoComment.value = value;
                      },
                    ),
                    Divider(
                      color: Colors.grey.shade200,
                    )
                  ],
                ),
              ),
              Divider(
                thickness: 12,
                color: Colors.grey.shade200,
              ),
              SwitchListTile(
                title: Text("Allow Others to share",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                activeColor: AppColors.themeColor,
                selected: _postController.isShareAllowed.value == true,
                onChanged: (value) {
                  _postController.isShareAllowed.value = value;
                },
                value: _postController.isShareAllowed.value,
              ),
              SwitchListTile(
                title: Text("Allow Others to save",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                activeColor: AppColors.themeColor,
                selected: _postController.isSaveAllowed.value == true,
                onChanged: (value) {
                  _postController.isSaveAllowed.value = value;
                },
                value: _postController.isSaveAllowed.value,
              ),
              SwitchListTile(
                title: Text("Don't show in nearby channel",
                    style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                activeColor: AppColors.themeColor,
                selected: _postController.showInNearByChannel.value == true,
                onChanged: (value) {
                  _postController.showInNearByChannel.value = value;
                },
                value: _postController.showInNearByChannel.value,
              ),
              SizedBox(
                height: 72.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
