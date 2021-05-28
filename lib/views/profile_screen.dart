import 'dart:io';

import 'package:Milto/views/followers_view.dart';
import 'package:Milto/views/following_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

import '../controllers/home_controller.dart';
import '../controllers/profile_controller.dart';
import '../style/AppColors.dart';
import 'edit_profile_view.dart';




class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> with SingleTickerProviderStateMixin {
  HomeController controller = Get.find<HomeController>();
  ProfileController profileController = Get.put(ProfileController());
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    profileController.requestForUserProfile();
    _tabController = new TabController(length: 3, vsync: this);
    controller.requestForFollowerList();
    controller.requestForFollowingList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        title: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            "Profile",
            style: TextStyle(fontWeight: FontWeight.w400),
          ),
        ),
        elevation: 0.0,
        titleSpacing: 0.0,
        actions: [
          RaisedButton(
            elevation: 0.0,
            color: Colors.transparent,
            onPressed: () {
              profileController.logOut();
            },
            child: Text(
              "LogOut",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 150.0,
                    child: Container(
                      color: Colors.pinkAccent,
                      child: Column(
                        children: [
                          profileController.selectedImagePath.value == '' &&
                                  profileController.pref.read('cover') !=null
                              ? Image.network(
                                  profileController.pref.read("cover"),
                                  fit: BoxFit.fill,
                                  width: double.infinity,
                                  height: 150)
                              : Obx(() {
                                  return Expanded(
                                      child: Image.file(
                                    File(profileController
                                        .selectedImagePath.value),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    height: 150,
                                  ));
                                })
                        ],
                      ),
                    )),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 40),
                          Text(profileController.pref.read("name")),
                          Text(profileController.pref.read("email"),
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 13)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    SizedBox(width: 40),
                    Expanded(child: GestureDetector(
                        onTap: (){
                          Get.to(FollowingView());
                        },
                        child: Text('Following(${controller.followingList.length})'))),
                    Expanded(child: GestureDetector(
                        onTap: (){
                          Get.to(FollowersView());
                        },
                        child: Text('Followers(${controller.followerList.length})'))),
                    Expanded(child: Text('Group(0)')),
                  ],
                ),
                SizedBox(height: 24.0),
                TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: AppColors.themeColor,
                  indicator: UnderlineTabIndicator(
                    borderSide:
                        BorderSide(width: 3.0, color: AppColors.themeColor),
                    insets: EdgeInsets.symmetric(horizontal: 32.0),
                  ),
                  tabs: [
                    Tab(
                      text: 'Post',
                    ),
                    Tab(
                      text: 'Gallery',
                    ),
                    Tab(
                      text: 'Saved',
                    )
                  ],
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      LimitedBox(
                        maxHeight: double.infinity,
                        child: GetX<HomeController>(
                          builder: (controller) {
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: controller.currentUserPostList.length,
                              shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) {
                                return Container(
                                  padding: EdgeInsets.all(12.0),
                                  margin: EdgeInsets.only(bottom: 12.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          controller.currentUserPostList[index]
                                                      .user[0].image ==
                                                  "https://sritsolution.com/hello/"
                                              ? Icon(
                                                  Icons.account_circle_rounded,
                                                  size: 48.0,
                                                  color: Colors.grey.shade400,
                                                )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50)),
                                                  child: CachedNetworkImage(
                                                    width: 48,
                                                    height: 48,
                                                    fit: BoxFit.cover,
                                                    imageUrl: controller
                                                        .currentUserPostList[
                                                            index]
                                                        .user[0]
                                                        .image,
                                                    placeholder:
                                                        (context, url) =>
                                                            Image.asset(
                                                      'assets/images/loading.gif',
                                                      fit: BoxFit.cover,
                                                    ),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      size: 48.0,
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                  ),
                                                ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                controller
                                                    .currentUserPostList[index]
                                                    .user[0]
                                                    .name,
                                                style: TextStyle(
                                                    fontSize: 16.0,
                                                    fontWeight:
                                                        FontWeight.w400),
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
                                        padding: controller
                                                    .currentUserPostList[index]
                                                    .type !=
                                                "text"
                                            ? EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 12.0)
                                            : EdgeInsets.symmetric(
                                                vertical: 72.0,
                                                horizontal: 12.0),
                                        color: controller
                                                    .currentUserPostList[index]
                                                    .type !=
                                                "text"
                                            ? Colors.grey.shade50
                                            : controller
                                                        .currentUserPostList[
                                                            index]
                                                        .color !=
                                                    "null"
                                                ? HexColor(controller
                                                    .currentUserPostList[index]
                                                    .color)
                                                : Colors.grey.shade50,
                                        child: Column(
                                          children: [
                                            Align(
                                              child: Text(
                                                controller
                                                    .currentUserPostList[index]
                                                    .description,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                  color: controller
                                                              .currentUserPostList[
                                                                  index]
                                                              .type !=
                                                          "text"
                                                      ? Colors.grey
                                                      : controller
                                                                  .currentUserPostList[
                                                                      index]
                                                                  .color !=
                                                              "null"
                                                          ? HexColor(controller
                                                                          .currentUserPostList[
                                                                              index]
                                                                          .color)
                                                                      .computeLuminance() >
                                                                  0.5
                                                              ? Colors.black
                                                              : Colors.white
                                                          : Colors.grey.shade50,
                                                ),
                                              ),
                                              alignment: controller
                                                          .currentUserPostList[
                                                              index]
                                                          .type ==
                                                      "text"
                                                  ? Alignment.center
                                                  : Alignment.topLeft,
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12.0,
                                      ),
                                      controller.currentUserPostList[index]
                                                  .content !=
                                              "https://sritsolution.com/hello/"
                                          ? controller
                                                      .currentUserPostList[
                                                          index]
                                                      .type ==
                                                  "img"
                                              ? ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(2.0)),
                                                  child: CachedNetworkImage(
                                                    width: double.infinity,
                                                    height: 420,
                                                    fit: BoxFit.cover,
                                                    imageUrl: controller
                                                        .currentUserPostList[
                                                            index]
                                                        .content,
                                                    placeholder:
                                                        (context, url) =>
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
                                                    controller:
                                                        ChewieController(
                                                      videoPlayerController:
                                                          VideoPlayerController
                                                              .network(controller
                                                                  .currentUserPostList[
                                                                      index]
                                                                  .content),
                                                      aspectRatio: 3 / 2,
                                                      allowedScreenSleep: false,
                                                      autoInitialize: true,
                                                      autoPlay: false,
                                                      looping: false,
                                                      showControlsOnInitialize:
                                                          false,

                                                      deviceOrientationsAfterFullScreen: [
                                                        DeviceOrientation
                                                            .portraitUp,
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
                                                      errorBuilder: (context,
                                                          errorMessage) {
                                                        return Center(
                                                          child: Text(
                                                            errorMessage,
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
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
                                              FlutterReactionButtonCheck(
                                                onReactionChanged:
                                                    (reaction, i, isChecked) {
                                                  print(
                                                      'reaction selected index: $index');
                                                  controller
                                                      .requestForToSendReaction(
                                                          controller
                                                              .currentUserPostList[
                                                                  index]
                                                              .id,
                                                          (i + 1).toString());
                                                },
                                                reactions: <Reaction>[
                                                  Reaction(
                                                    title: Text("Like"),
                                                    icon: Icon(
                                                      Icons.thumb_up,
                                                      color: Colors.blueAccent,
                                                    ),
                                                  ),
                                                  Reaction(
                                                    title: Text("Happy"),
                                                    icon: SvgPicture.asset(
                                                      "assets/images/happy.svg",
                                                      width: 24.0,
                                                      height: 24.0,
                                                    ),
                                                  ),
                                                  Reaction(
                                                    title: Text("Love"),
                                                    icon: SvgPicture.asset(
                                                      "assets/images/in-love.svg",
                                                      width: 24.0,
                                                      height: 24.0,
                                                    ),
                                                  ),
                                                  Reaction(
                                                      title: Text("Sad"),
                                                      icon: SvgPicture.asset(
                                                        "assets/images/sad.svg",
                                                        width: 24.0,
                                                        height: 24.0,
                                                      )),
                                                  Reaction(
                                                    title: Text("Angry"),
                                                    icon: SvgPicture.asset(
                                                      "assets/images/angry.svg",
                                                      width: 24.0,
                                                      height: 24.0,
                                                    ),
                                                  ),
                                                ],
                                                initialReaction: Reaction(
                                                  icon: controller.checkCurrentUserReaction(
                                                              controller
                                                                  .currentUserPostList[
                                                                      index]
                                                                  .postReaction) ==
                                                          ""
                                                      ? Icon(
                                                          Icons
                                                              .thumb_up_alt_outlined,
                                                          color: Colors
                                                              .grey.shade400,
                                                        )
                                                      : controller.checkCurrentUserReaction(
                                                                  controller
                                                                      .currentUserPostList[
                                                                          index]
                                                                      .postReaction) !=
                                                              " "
                                                          ? SvgPicture.asset(
                                                              controller.checkCurrentUserReaction(
                                                                  controller
                                                                      .currentUserPostList[
                                                                          index]
                                                                      .postReaction),
                                                              width: 24.0,
                                                              height: 24.0,
                                                            )
                                                          : Icon(
                                                              Icons.thumb_up,
                                                              color: Colors
                                                                  .blueAccent,
                                                            ),
                                                ),
                                                boxItemsSpacing: 8.0,
                                                boxPadding: EdgeInsets.all(4.0),
                                                boxAlignment:
                                                    Alignment.bottomLeft,
                                                boxDuration: const Duration(
                                                    milliseconds: 100),
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
                                          GestureDetector(
                                            onTap: () {
                                              showCommentBottomSheet(context);
                                            },
                                            child: Column(
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
                      Container(child: Center(child: Text('Gallery'))),
                      Container(child: Center(child: Text('Saved'))),
                    ],
                    controller: _tabController,
                  ),
                ),
              ],
            ),
            Positioned(
              top: 110.0,
              right: 6,
              child: Container(
                  height: 30,
                  child: Obx(() {
                    return profileController.selectedImagePath.value == ''
                        ? RaisedButton(
                            onPressed: () {
                              profileController.getImage(ImageSource.gallery);
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: AppColors.white,
                            color: AppColors.themeColor,
                            child: Row(
                              children: [
                                Text(
                                  'Cover ',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Icon(Icons.edit, size: 16)
                              ],
                            ),
                          )
                        : RaisedButton(
                            onPressed: () {
                              profileController.requestForAddCoverPhoto();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0)),
                            textColor: AppColors.white,
                            color: AppColors.themeColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Update ',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          );
                  })),
            ),
            Positioned(
              top: 120.0,
              left: 16.0,
              child: profileController.pref.read("pic") == ""
                  ? Icon(
                      Icons.account_circle_rounded,
                      size: 60.0,
                      color: Colors.grey.shade400,
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: CachedNetworkImage(
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        imageUrl: profileController.pref.read("pic"),
                        placeholder: (context, url) => Image.asset(
                          'assets/images/loading.gif',
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(
                          Icons.account_circle_rounded,
                          size: 60.0,
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
            ),
            Positioned(
              top: 180.0,
              right: 15,
              child: Container(
                height: 30,
                child: RaisedButton(
                  onPressed: () {
                    Get.to(EditProfile());
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  textColor: AppColors.white,
                  color: AppColors.themeColor,
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
            ),
          ],
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
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: 8.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          keyboardType: TextInputType.multiline,
                          validator: (input) =>
                              input.isEmpty ? "Please write something" : null,
                          // controller: _loginController.emailController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 0.0),
                            hintText: 'Write Something...',
                            hintStyle: TextStyle(color: Colors.grey.shade400),
                            labelStyle: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.0)),
                              borderSide:
                                  new BorderSide(color: AppColors.themeColor),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColors.themeColor,
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          );
        });
  }
}
