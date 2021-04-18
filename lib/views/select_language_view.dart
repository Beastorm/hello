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
      body: LimitedBox(
        maxHeight: 400,
        child: GetX<PostController>(builder: (controller) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: controller.languageList.length,
            shrinkWrap: true,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                controller.currentPostLanguage.value =
                    controller.languageList[index];
                print(".................");
                print(controller.currentPostLanguage.value);
                Get.back();
              },
              child: Padding(
                padding: const EdgeInsets.only(bottom: 2.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding:
                      EdgeInsets.symmetric(vertical: 6.0, horizontal: 14.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white.withOpacity(0.3),
                        child: Text(
                          controller.languageList[index][0].capitalize,
                          style: TextStyle(color: AppColors.themeColor),
                        ),
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Text(controller.languageList[index],
                          style: TextStyle(color: Colors.grey)),
                      Spacer(),
                      Obx(
                        () => Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                            vertical: 8.0,
                          ),
                          width: 32.0,
                          height: 32.0,
                          child: controller.languageList[index] ==
                                  controller.currentPostLanguage.value
                              ? Icon(
                                  Icons.check,
                                  color: AppColors.themeColor,
                                  size: 16,
                                )
                              : SizedBox(),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.all(Radius.circular(4.0))),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
