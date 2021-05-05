import 'package:Milto/controllers/login_controller.dart';
import 'package:Milto/style/AppColors.dart';
import 'package:Milto/views/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class MultipleLanguageSelView extends StatelessWidget {
  LoginController loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade100,
        title: Text(
          "Select your preferred languages",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        actions: [
          Icon(
            Icons.translate,
            color: Colors.black54,
          ),
          SizedBox(
            width: 16.0,
          )
        ],
      ),
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 48.0,
        child: RaisedButton(
          color: AppColors.themeColor,
          elevation: 0.0,
          onPressed: () {
            Get.offAll(
              PagesScreen(
                currentIndex: 0,
              ),
            );
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
          child: GetX<LoginController>(builder: (controller) {
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
    );
  }
}
