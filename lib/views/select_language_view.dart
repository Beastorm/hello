import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/post_controller.dart';
import '../style/AppColors.dart';

// ignore: must_be_immutable
class SelectLanguageView extends StatelessWidget {
  PostController postController = Get.find<PostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        title: Text(
          "Select Language",
          style: TextStyle(color: AppColors.themeColor, fontSize: 16.0),
        ),
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 48.0,
        child: RaisedButton(
          color: AppColors.themeColor,
          elevation: 0.0,
          onPressed: () {
            Get.back();
          },
          child: Text(
            "save",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: LimitedBox(
          maxHeight: 400,
          child: GetX<PostController>(
            builder: (controller) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 3.5,
                ),
                itemCount: controller.languageList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    controller.currentPostLanguage.value =
                        controller.languageList[index];
                  },
                  child: Obx(
                    () => Container(
                      width: 100,
                      alignment: Alignment.centerLeft,
                      padding: controller.languageList[index] ==
                              controller.currentPostLanguage.value
                          ? EdgeInsets.only(left: 16.0, right: 4.0)
                          : EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 0.0),
                      child: Row(
                        children: [
                          controller.languageList[index] !=
                                  controller.currentPostLanguage.value
                              ? CircleAvatar(
                                  minRadius: 20.0,
                                  backgroundColor:
                                      AppColors.langColorList[index],
                                  child: Text(
                                    controller
                                        .languageList[index][0].capitalize,
                                    style: TextStyle(
                                        color: AppColors.langColorList[index]
                                                    .computeLuminance() >
                                                0.5
                                            ? Colors.black
                                            : Colors.white,
                                        fontSize: 14.0),
                                  ),
                                )
                              : SizedBox(),
                          // SizedBox(
                          //   width: 2.0,
                          // ),
                          Text(controller.languageList[index],
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: controller.languageList[index] ==
                                          controller.currentPostLanguage.value
                                      ? Colors.white
                                      : Colors.black54,
                                  fontSize: 12.0)),
                          SizedBox(
                            width: 2.0,
                          ),
                          Spacer(),
                          controller.languageList[index] ==
                                  controller.currentPostLanguage.value
                              ? Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 2.0,
                                  ),
                                  width: 22.0,
                                  height: 22.0,
                                  child: controller.languageList[index] ==
                                          controller.currentPostLanguage.value
                                      ? Icon(
                                          Icons.check,
                                          color: Colors.black,
                                          size: 15,
                                        )
                                      : SizedBox(),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0))),
                                )
                              : SizedBox(),
                          SizedBox(
                            width: 2.0,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: AppColors.langColorList[index]),
                        color: controller.languageList[index] ==
                                controller.currentPostLanguage.value
                            ? AppColors.langColorList[index]
                            : Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(100.0),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
