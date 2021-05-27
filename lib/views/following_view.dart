import 'package:Milto/controllers/home_controller.dart';
import 'package:Milto/style/AppColors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FollowingView extends StatelessWidget {
  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Following'),
        ),
        body: GetX<HomeController>(
          initState: (context) {
            homeController.requestForFollowingList();
          },
          builder: (controller) {
            if (controller.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.followingList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Card(
                    child: Container(
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      controller.followingList[index].userid[0]
                                                  .image ==
                                              "https://sritsolution.com/hello/"
                                          ? Icon(
                                              Icons.account_circle_rounded,
                                              size: 48.0,
                                              color: Colors.grey.shade400,
                                            )
                                          : ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50)),
                                              child: CachedNetworkImage(
                                                width: 25,
                                                height: 25,
                                                fit: BoxFit.cover,
                                                imageUrl: controller
                                                    .followingList[index]
                                                    .userid[0]
                                                    .image,
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  'assets/images/loading.gif',
                                                  fit: BoxFit.cover,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(
                                                  Icons.account_circle_rounded,
                                                  size: 48.0,
                                                  color: Colors.grey.shade400,
                                                ),
                                              ),
                                            ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  text: controller
                                                      .followingList[index]
                                                      .followBy[0]
                                                      .name,
                                                  style: TextStyle(
                                                      color: Colors.black))),
                                          Text(
                                            controller.followingList[index]
                                                .followBy[0].email,
                                            style: TextStyle(fontSize: 9),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                controller.checkFollowedUser(controller
                                            .postList[index].user[0].id) ==
                                        1
                                    ? Align(
                                        alignment: Alignment.centerRight,
                                        child: RaisedButton(
                                          onPressed: () async {
                                            await controller
                                                .requestForUnFollowUserProcess(
                                                    controller.postList[index]
                                                        .user[0].id);
                                          },
                                          child: Text(
                                            "UnFollow",
                                            style: TextStyle(
                                                color: AppColors.themeColor),
                                          ),
                                          color: Colors.transparent,
                                          elevation: 0.0,
                                        ),
                                      )
                                    : controller.checkFollowedUser(controller
                                                .postList[index].user[0].id) ==
                                            0
                                        ? SizedBox()
                                        : RaisedButton(
                                            onPressed: () async {
                                              await controller
                                                  .requestForFollowUserProcess(
                                                      controller.postList[index]
                                                          .user[0].id);
                                            },
                                            child: Text(
                                              "follow",
                                              style: TextStyle(
                                                  color: AppColors.themeColor),
                                            ),
                                            color: Colors.transparent,
                                            elevation: 0.0,
                                          ),
                                SizedBox()
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                                'You are following ${controller.followingList[index].followBy[0].name} since ${controller.followingList[index].followBy[0].date}',
                                style: TextStyle(fontSize: 13)),
                            SizedBox(height: 10),

                            // follow section
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
