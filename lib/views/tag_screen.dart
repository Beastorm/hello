import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';
import '../controllers/tag_controller.dart';
import '../style/AppColors.dart';

class TagScreenWidget extends StatelessWidget {
  final TagController _tagController = Get.put(TagController());
  final PostController _postController = Get.find<PostController>();
  final _formKey = GlobalKey<FormState>();

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
              "Apply",
              style: TextStyle(color: AppColors.themeColor, fontSize: 16.0),
            ),
            onPressed: () {
              if (_formKey.currentState.validate()) {
                _postController.appliedTags = _tagController.appliedTags;
                Get.back();
              }
            },
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 48,
                margin: EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (input) =>
                        input.length < 5 ? "at least 5 characters" : null,
                    controller: _tagController.textEditingController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'create tag',
                      labelText: '#tag_name',
                      labelStyle: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              new BorderSide(color: AppColors.themeColor)),
                      suffixIcon: RaisedButton(
                        elevation: 0.0,
                        color: Colors.transparent,
                        child: Text(
                          "create",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.themeColor,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _tagController.requestForTagCreate();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 56.0,
              ),
              Text("Available Tags"),
              SizedBox(
                height: 24.0,
              ),
              LimitedBox(
                maxHeight: 100000,
                child: GetX<TagController>(builder: (controller) {
                  return ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: controller.tagList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 48.0,
                        margin: EdgeInsets.symmetric(vertical: 4.0),
                        color: Colors.grey.shade200,
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.tagList[index].name),
                            GestureDetector(
                              onTap: () {
                                controller.addTagOrDeleteTag(
                                    controller.tagList[index]);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                ),
                                width: 32.0,
                                height: 32.0,
                                child: controller.checkTag(
                                            controller.tagList[index]) ==
                                        true
                                    ? Icon(
                                        Icons.check,
                                        color: AppColors.themeColor,
                                      )
                                    : SizedBox(),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border:
                                        Border.all(color: Colors.grey.shade300),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(40.0))),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
