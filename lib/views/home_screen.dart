import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/controllers/home_controller.dart';
import 'package:hello/style/AppColors.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade100,
            child: Column(
              children: [
                SizedBox(
                  height: 24.0,
                ),
                Align(
                  child: Container(
                    width: 80,
                    padding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 8.0),
                    child: Text(
                      "Posts",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    decoration: BoxDecoration(
                        color: AppColors.themeColor,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(24.0),
                            bottomRight: Radius.circular(24.0))),
                  ),
                  alignment: Alignment.topLeft,
                ),
                SizedBox(
                  height: 16.0,
                ),
                LimitedBox(
                  maxHeight: 2000000000000000,
                  child: GetX<HomeController>(
                    builder: (controller) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: controller.postList.length,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.all(12.0),
                            margin: EdgeInsets.only(bottom: 12.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    controller.postList[index].user[0].image ==
                                            ""
                                        ? Icon(
                                            Icons.account_circle_rounded,
                                            size: 48.0,
                                            color: Colors.grey.shade400,
                                          )
                                        : ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),
                                            child: CachedNetworkImage(
                                              width: 48,
                                              height: 48,
                                              fit: BoxFit.cover,
                                              imageUrl: controller
                                                  .postList[index]
                                                  .user[0]
                                                  .image,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                'assets/images/loading.gif',
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                Icons.account_circle_rounded,
                                                size: 48.0,
                                                color: Colors.grey.shade400,
                                              ),
                                            ),
                                            // child: Image.network(
                                            //   controller.postList[index].user[0]
                                            //       .image,
                                            //   width: 48,
                                            //   height: 48,
                                            //   fit: BoxFit.cover,
                                            //   errorBuilder:
                                            //       (BuildContext context,
                                            //           Object exception,
                                            //           StackTrace stackTrace) {
                                            //     return Icon(
                                            //       Icons.account_circle_rounded,
                                            //       size: 48.0,
                                            //       color: Colors.grey.shade400,
                                            //     );
                                            //   },
                                            // ),
                                          ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller
                                              .postList[index].user[0].name,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: 4.0,
                                        ),
                                        Text(
                                          "Friend",
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey.shade500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Icon(Icons.more_vert_outlined),
                                    SizedBox(
                                      width: 16.0,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 12.0),
                                  color: Colors.grey.shade50,
                                  child: Column(
                                    children: [
                                      Align(
                                        child: Text(
                                          controller
                                              .postList[index].description,
                                          style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.grey.shade600,
                                          ),
                                        ),
                                        alignment: Alignment.topLeft,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  child: CachedNetworkImage(
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        controller.postList[index].content,
                                    placeholder: (context, url) => Image.asset(
                                      'assets/images/loading.gif',
                                      fit: BoxFit.cover,
                                    ),
                                    errorWidget: (context, url, error) =>
                                        SizedBox(),
                                  ),
                                ),
                                SizedBox(
                                  height: 24.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                        Text(
                                          "Like",
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.share_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.comment_outlined,
                                          color: Colors.grey.shade400,
                                        ),
                                        Text(
                                          "Comment",
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.save_alt,
                                          color: Colors.grey.shade400,
                                        ),
                                        Text(
                                          "Save",
                                          style: TextStyle(
                                            color: Colors.grey.shade400,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            decoration: new BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 1.0,
                                  // has the effect of softening the shadow
                                  spreadRadius: 1.0,
                                  // has the effect of extending the shadow
                                  offset: Offset(
                                    0, // horizontal, move right 10
                                    1, // vertical, move down 10
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
