import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hello/common_components/MySnackBar.dart';
import 'package:hello/controllers/home_controller.dart';
import 'package:hello/style/AppColors.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

import '../style/AppColors.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _homeController = Get.put(HomeController());
  String reactionStr = 'React';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.grey.shade100,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  height: 60,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          MySnackbar.infoSnackBar('Coming Soon', '');
                        },
                        child: Container(
                          child: SvgPicture.asset(
                            "assets/images/language_color.svg",
                            width: 24.0,
                            height: 24.0,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () {
                          MySnackbar.infoSnackBar('Coming Soon', '');
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40.0))),
                          height: 35,
                          width: 220,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 18, top: 8, bottom: 8),
                            child: Text(
                              'Search anything',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            MySnackbar.infoSnackBar('Coming Soon', '');
                          },
                          child: Icon(Icons.person_pin, size: 30))

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            MySnackbar.infoSnackBar('Coming Soon', 'sotries comming soon');
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              height: 120,
                              width: 80,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                            left: 18,
                                            right: 18,
                                            top: 18,
                                            ),
                                        child: SvgPicture.asset(
                                            'assets/images/add.svg')),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 20, top: 6),
                                    child: Text('add story',
                                        style: TextStyle(fontSize: 11)),
                                  ),
                                ],
                              ))),
                      GestureDetector(
                          onTap: () {
                            MySnackbar.infoSnackBar('Coming Soon', 'sotries comming soon');
                          },
                          child: Container(
                            margin: EdgeInsets.only(left: 6),
                              decoration: BoxDecoration(
                                  color: Colors.lightBlue.shade100,
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                              height: 120,
                              width: 80,
                              child: Row(

                                children: [
                                  Expanded(
                                    child: Container(
                                        margin: EdgeInsets.only(
                                          top: 60,
                                        ),
                                        child: Icon(Icons.person_pin)),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 6, top: 60),
                                    child: Text('Hello all',
                                        style: TextStyle(fontSize: 11)),
                                  ),
                                ],
                              ))),
                    ],
                  ),
                ),
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
                  maxHeight: double.infinity,
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
                                  color: controller.postList[index].type !=
                                          "text"
                                      ? Colors.grey.shade50
                                      : controller.postList[index].color !=
                                              "null"
                                          ? HexColor(
                                              controller.postList[index].color)
                                          : Colors.grey.shade50,
                                  child: Column(
                                    children: [
                                      Align(
                                        child: Text(
                                          controller
                                              .postList[index].description,
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: controller
                                                        .postList[index].type !=
                                                    "text"
                                                ? Colors.grey
                                                : controller.postList[index]
                                                            .color !=
                                                        "null"
                                                    ? HexColor(controller
                                                                    .postList[
                                                                        index]
                                                                    .color)
                                                                .computeLuminance() >
                                                            0.5
                                                        ? Colors.black
                                                        : Colors.white
                                                    : Colors.grey.shade50,
                                          ),
                                        ),
                                        alignment: Alignment.center,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 12.0,
                                ),
                                controller.postList[index].content !=
                                        "https://sritsolution.com/hello/"
                                    ? controller.postList[index].type == "img"
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.0)),
                                            child: CachedNetworkImage(
                                              width: double.infinity,
                                              height: 180,
                                              fit: BoxFit.cover,
                                              imageUrl: controller
                                                  .postList[index].content,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                'assets/images/loading.gif',
                                                fit: BoxFit.cover,
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      SizedBox(),
                                            ),
                                          )
                                        : Container(
                                            height: 220,
                                            alignment: Alignment.center,
                                            child: Chewie(
                                              controller: ChewieController(
                                                videoPlayerController:
                                                    VideoPlayerController
                                                        .network(controller
                                                            .postList[index]
                                                            .content),
                                                aspectRatio: 3 / 2,
                                                allowedScreenSleep: false,
                                                autoInitialize: true,
                                                autoPlay: false,
                                                looping: false,
                                                deviceOrientationsAfterFullScreen: [
                                                  DeviceOrientation.portraitUp,
                                                  DeviceOrientation
                                                      .portraitDown,
                                                ],
                                                // customControls: Container(
                                                //   height: videoPlayerController.value.size.height,
                                                //   width: videoPlayerController.value.size.width,
                                                //   child: Column(
                                                //     mainAxisAlignment: MainAxisAlignment.center,
                                                //     children: [
                                                //       Center(
                                                //         child: Container(
                                                //           height: 70,
                                                //           width: 70,
                                                //           decoration: BoxDecoration(
                                                //             borderRadius: BorderRadius.circular(18),
                                                //             color: Colors.black.withOpacity(0.5),
                                                //             shape: BoxShape.rectangle,
                                                //               border: Border.all(
                                                //                 width: 4,
                                                //                 color: Colors.white
                                                //               )
                                                //           ),
                                                //           child: IconButton(
                                                //             icon: Icon(Icons.play_arrow_rounded,color: Colors.white,),
                                                //             onPressed: () {
                                                //               if (videoPlayerController.value.isPlaying) {
                                                //                 videoPlayerController.pause();
                                                //               } else {
                                                //                 // If the video is paused, play it.
                                                //                 videoPlayerController.play();
                                                //               }
                                                //             },
                                                //           ),
                                                //         ),
                                                //       ),
                                                //     ],
                                                //   ),
                                                // ),
                                                errorBuilder:
                                                    (context, errorMessage) {
                                                  return Center(
                                                    child: Text(
                                                      errorMessage,
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          )
                                    : SizedBox(),
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
                                          Icons.share_outlined,
                                          color: Colors.grey.shade700,
                                          size: 22,
                                        ),
                                        Text(
                                          "Share",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        FlutterReactionButtonCheck(
                                          onReactionChanged:
                                              (reaction, index, isChecked) {
                                            print(
                                                'reaction selected index: $index');
                                          },
                                          reactions: <Reaction>[
                                            Reaction(
                                              icon: Icon(
                                                Icons.thumb_up,
                                                color: AppColors.blueColor,
                                              ),
                                            ),
                                            Reaction(
                                              icon: SvgPicture.asset(
                                                "assets/images/happy.svg",
                                                width: 24.0,
                                                height: 24.0,
                                              ),
                                            ),
                                            Reaction(
                                                icon: SvgPicture.asset(
                                              "assets/images/sad.svg",
                                              width: 24.0,
                                              height: 24.0,
                                            )),
                                            Reaction(
                                              icon: SvgPicture.asset(
                                                "assets/images/love.svg",
                                                width: 24.0,
                                                height: 24.0,
                                              ),
                                            ),
                                            Reaction(
                                              icon: SvgPicture.asset(
                                                "assets/images/angry.svg",
                                                width: 24.0,
                                                height: 24.0,
                                              ),
                                            ),
                                          ],
                                          initialReaction: Reaction(
                                            icon: Icon(
                                              Icons.thumb_up_alt_outlined,
                                              color: Colors.grey.shade700,
                                              size: 23,
                                            ),
                                          ),
                                          selectedReaction: Reaction(
                                            icon: Icon(
                                              Icons.thumb_up,
                                              color: AppColors.blueColor,
                                            ),
                                          ),
                                          boxItemsSpacing: 8.0,
                                          boxPadding: EdgeInsets.all(4.0),
                                          boxAlignment: Alignment.bottomLeft,
                                          boxDuration:
                                              const Duration(milliseconds: 100),
                                        ),
                                        Text(
                                          reactionStr,
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        showCommentBottomSheet(context);
                                      },
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.comment_outlined,
                                            color: Colors.grey.shade700,
                                            size: 22,
                                          ),
                                          Text(
                                            "Comment",
                                            style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 13),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.repeat,
                                          color: Colors.grey.shade700,
                                          size: 22,
                                        ),
                                        Text(
                                          "Repost",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.save_alt,
                                          color: Colors.grey.shade700,
                                          size: 22,
                                        ),
                                        Text(
                                          "Save",
                                          style: TextStyle(
                                              color: Colors.grey.shade700,
                                              fontSize: 13),
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

  showCommentBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  // child: Text('Enter your address',),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(hintText: 'Write something...'),
                    autofocus: true,
                    //controller: _newMediaLinkAddressController,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.bottomRight,
                  height: 30,
                  child: RaisedButton(
                    elevation: 0.0,
                    onPressed: () {
                      //Get.to(EditProfile());
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    textColor: AppColors.white,
                    color: AppColors.themeColor,
                    child: Text(
                      'send',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
}
