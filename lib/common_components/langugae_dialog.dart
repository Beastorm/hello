import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:random_color/random_color.dart';

import '../controllers/home_controller.dart';
import '../style/AppColors.dart';

languageDialog(bool showDialog) {
  if (!showDialog) return;
  RandomColor _randomColor = RandomColor();
  Get.find<HomeController>();
  Get.defaultDialog(
    title: "Choose Language",
    titleStyle: TextStyle(fontSize: 18.0),
    middleText: "You can select more than one language",
    radius: 4.0,
    content: LimitedBox(
      maxHeight: 400,
      child: GetX<HomeController>(builder: (controller) {
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 3.5,
          ),
          itemCount: controller.languageList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              controller
                  .addLanguageOrDeleteLanguage(controller.languageList[index]);
            },
            child: Container(
              width: 100,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 0.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white.withOpacity(0.3),
                    child: Text(
                      controller.languageList[index][0].capitalize,
                      style: TextStyle(
                          color: _randomColor.randomColor(
                              colorSaturation:
                                  ColorSaturation.mediumSaturation),
                          fontSize: 14.0),
                    ),
                  ),
                  // SizedBox(
                  //   width: 2.0,
                  // ),
                  Text(controller.languageList[index],
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey, fontSize: 12.0)),
                  SizedBox(
                    width: 2.0,
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                      vertical: 2.0,
                    ),
                    width: 22.0,
                    height: 22.0,
                    child: controller.checkLanguage(
                                controller.languageList[index]) ==
                            true
                        ? Icon(
                            Icons.check,
                            color: AppColors.themeColor,
                            size: 15,
                          )
                        : SizedBox(),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  ),
                  SizedBox(
                    width: 2.0,
                  ),
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(
                    color: _randomColor
                        .randomColor(
                            colorSaturation: ColorSaturation.mediumSaturation)
                        .withOpacity(0.5)),
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
          ),
        );
      }),
    ),
    barrierDismissible: true,
  );
}
