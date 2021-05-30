import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../style/AppColors.dart';

languageDialog(bool showDialog) {
  if (!showDialog) return;
  HomeController homeController = Get.find<HomeController>();
  Get.defaultDialog(
    confirm: Container(
      width: double.infinity,
      child: RaisedButton(
        color: AppColors.themeColor,
        elevation: 0.0,
        onPressed: () {
          homeController.postList.refresh();
          homeController.requestALLPost();
          Get.back();
        },
        child: Text(
          "save",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    backgroundColor: Colors.white,
    title: "Choose your preferred languages",
    titleStyle: TextStyle(fontSize: 16.0, color: Colors.black54),
    middleText: "You can select more than one language",
    radius: 4.0,
    content: Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: LimitedBox(
        maxHeight: 400,
        child: GetX<HomeController>(builder: (controller) {
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
                controller.changeLanguage(controller.languageList[index]);
              },
              child: Obx(
                () => Container(
                  width: 100,
                  alignment: Alignment.centerLeft,
                  padding: controller.languageList[index] ==
                          controller.selectedLanguageByUser.value
                      ? EdgeInsets.only(left: 16.0, right: 4.0)
                      : EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
                  child: Row(
                    children: [
                      controller.languageList[index] !=
                              controller.selectedLanguageByUser.value
                          ? CircleAvatar(
                              minRadius: 20.0,
                              backgroundColor: AppColors.langColorList[index],
                              child: Text(
                                controller.languageList[index][0].capitalize,
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
                                      controller.selectedLanguageByUser.value
                                  ? Colors.white
                                  : Colors.black54,
                              fontSize: 12.0)),
                      SizedBox(
                        width: 2.0,
                      ),
                      Spacer(),
                      controller.languageList[index] ==
                              controller.selectedLanguageByUser.value
                          ? Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                vertical: 2.0,
                              ),
                              width: 22.0,
                              height: 22.0,
                              child: controller.languageList[index] ==
                                      controller.selectedLanguageByUser.value
                                  ? Icon(
                                      Icons.check,
                                      color: Colors.black,
                                      size: 15,
                                    )
                                  : SizedBox(),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(40.0))),
                            )
                          : SizedBox(),
                      SizedBox(
                        width: 2.0,
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.langColorList[index]),
                    color: controller.languageList[index] ==
                            controller.selectedLanguageByUser.value
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
        }),
      ),
    ),
    barrierDismissible: false,
  );
}
