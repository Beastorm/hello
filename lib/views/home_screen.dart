import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:video_player/video_player.dart';

import '../common_components/MySnackBar.dart';
import '../common_components/langugae_dialog.dart';
import '../controllers/follow_controller.dart';
import '../controllers/home_controller.dart';
import '../style/AppColors.dart';
import 'comment_view.dart';
import 'image_viewer_view.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _homeController = Get.put(HomeController());
  final FollowController followController = Get.put(FollowController());
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  var _formKey = GlobalKey<FormState>();
  TabController _tabController;
  String follow = 'Follow';

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        key: refreshKey,
        color: AppColors.themeColor,
        onRefresh: () async {
          await _homeController.requestALLPost();
          refreshKey.currentState.show(atTop: false);
          return null;
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              color: Colors.grey.shade100,
              child: LimitedBox(
                maxHeight: 20000,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 12, right: 12),
                      height: 60,
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              languageDialog(true);
                            },
                            child: Container(
                              child: SvgPicture.asset(
                                "assets/images/language_color.svg",
                                width: 24.0,
                                height: 24.0,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 12.0,
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
                              width: 150,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, top: 8, bottom: 8),
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.search,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'Search anything',
                                      style: TextStyle(
                                          color: Colors.black38, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // GestureDetector(
                          //     onTap: () {
                          //       Get.to(ProfileScreen());
                          //     },
                          //
                          //     child: Icon(Icons.person_pin, size: 30)),

                          Spacer(),
                          CircleAvatar(
                            backgroundColor: Colors.redAccent,
                            radius: 18,
                            child: IconButton(
                                icon: Icon(
                                  Icons.notifications,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 18,
                            child: IconButton(
                                icon: Icon(
                                  Icons.people,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.lightBlueAccent,
                            radius: 18,
                            child: IconButton(
                                icon: Icon(
                                  Icons.mark_chat_unread,
                                  size: 20,
                                  color: Colors.white,
                                ),
                                onPressed: () {}),
                          )
                        ],
                      ),
                    ),
                    TabBar(
                      unselectedLabelColor: Colors.grey,
                      labelColor: AppColors.themeColor,
                      indicatorWeight: 1.0,
                      indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(width: 3.0, color: Colors.transparent),
                        insets: EdgeInsets.symmetric(horizontal: 32.0),
                      ),
                      tabs: [
                        Tab(
                          text: 'Popular',
                        ),
                        Tab(
                          text: 'NearBy',
                        ),
                        Tab(
                          text: 'Video',
                        ),
                        Tab(
                          text: 'Follow',
                        )
                      ],
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
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
                                              controller.postList[index].user[0]
                                                          .image ==
                                                      "https://sritsolution.com/hello/"
                                                  ? Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      size: 48.0,
                                                      color:
                                                          Colors.grey.shade400,
                                                    )
                                                  : ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  50)),
                                                      child: CachedNetworkImage(
                                                        width: 48,
                                                        height: 48,
                                                        fit: BoxFit.cover,
                                                        imageUrl: controller
                                                            .postList[index]
                                                            .user[0]
                                                            .image,
                                                        placeholder:
                                                            (context, url) =>
                                                                Image.asset(
                                                          'assets/images/loading.gif',
                                                          fit: BoxFit.cover,
                                                        ),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            Icon(
                                                          Icons
                                                              .account_circle_rounded,
                                                          size: 48.0,
                                                          color: Colors
                                                              .grey.shade400,
                                                        ),
                                                      ),
                                                    ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    (controller.postList[index]
                                                            .user[0].name) ??
                                                        "",
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
                                                      color:
                                                          Colors.grey.shade500,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Spacer(),

                                              // follow section
                                              Obx(() {
                                                return controller
                                                            .checkFollowedUser(
                                                                controller
                                                                    .postList[
                                                                        index]
                                                                    .user[0]
                                                                    .id) ==
                                                        1
                                                    ? RaisedButton(
                                                        onPressed: () async {
                                                          await controller
                                                              .requestForUnFollowUserProcess(
                                                                  controller
                                                                      .postList[
                                                                          index]
                                                                      .user[0]
                                                                      .id);
                                                        },
                                                        child: Text(
                                                          "UnFollow",
                                                          style: TextStyle(
                                                              color: AppColors
                                                                  .themeColor),
                                                        ),
                                                        color:
                                                            Colors.transparent,
                                                        elevation: 0.0,
                                                      )
                                                    : controller.checkFollowedUser(
                                                                controller
                                                                    .postList[
                                                                        index]
                                                                    .user[0]
                                                                    .id) ==
                                                            -1
                                                        ? RaisedButton(
                                                            onPressed:
                                                                () async {
                                                              await controller
                                                                  .requestForFollowUserProcess(
                                                                      controller
                                                                          .postList[
                                                                              index]
                                                                          .user[
                                                                              0]
                                                                          .id);
                                                            },
                                                            child: Text(
                                                              "follow",
                                                              style: TextStyle(
                                                                  color: AppColors
                                                                      .themeColor),
                                                            ),
                                                            color: Colors
                                                                .transparent,
                                                            elevation: 0.0,
                                                          )
                                                        : SizedBox();
                                              }),

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
                                                        .postList[index].type !=
                                                    "text"
                                                ? EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 12.0)
                                                : EdgeInsets.symmetric(
                                                    vertical: 72.0,
                                                    horizontal: 12.0),
                                            color: controller
                                                        .postList[index].type !=
                                                    "text"
                                                ? Colors.white
                                                : controller.postList[index]
                                                            .color !=
                                                        "null"
                                                    ? HexColor(controller
                                                        .postList[index].color)
                                                    : Colors.white,
                                            child: Column(
                                              children: [
                                                Align(
                                                  child: Text(
                                                    controller.postList[index]
                                                        .description,
                                                    style: TextStyle(
                                                      fontSize: 18.0,
                                                      color: controller
                                                                  .postList[
                                                                      index]
                                                                  .type !=
                                                              "text"
                                                          ? Colors.grey
                                                          : controller
                                                                      .postList[
                                                                          index]
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
                                                              : Colors
                                                                  .grey.shade50,
                                                    ),
                                                  ),
                                                  alignment: controller
                                                              .postList[index]
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
                                          controller.postList[index].content !=
                                                  "https://sritsolution.com/hello/"
                                              ? controller.postList[index]
                                                          .type ==
                                                      "img"
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        Get.to(ImageViewerView(
                                                            controller
                                                                .postList[index]
                                                                .content));
                                                      },
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    2.0)),
                                                        child:
                                                            CachedNetworkImage(
                                                          width:
                                                              double.infinity,
                                                          height: 420,
                                                          fit: BoxFit.cover,
                                                          imageUrl: controller
                                                              .postList[index]
                                                              .content,
                                                          placeholder:
                                                              (context, url) =>
                                                                  Image.asset(
                                                            'assets/images/loading.gif',
                                                            fit: BoxFit.cover,
                                                          ),
                                                          errorWidget: (context,
                                                                  url, error) =>
                                                              SizedBox(),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      height: 260,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Chewie(
                                                        controller:
                                                            ChewieController(
                                                          videoPlayerController:
                                                              VideoPlayerController
                                                                  .network(controller
                                                                      .postList[
                                                                          index]
                                                                      .content),
                                                          aspectRatio: 3 / 2,
                                                          autoInitialize: true,
                                                          autoPlay: false,
                                                          showControlsOnInitialize:
                                                              false,
                                                          looping: false,

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
                                                        (reaction, i,
                                                            isChecked) {
                                                      print(
                                                          'reaction selected index: $index');
                                                      controller
                                                          .requestForToSendReaction(
                                                              controller
                                                                  .postList[
                                                                      index]
                                                                  .id,
                                                              (i + 1)
                                                                  .toString());
                                                    },
                                                    reactions: <Reaction>[
                                                      Reaction(
                                                        title: Text("Like"),
                                                        icon: Icon(
                                                          Icons.thumb_up,
                                                          color:
                                                              Colors.blueAccent,
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
                                                          "assets/images/love.svg",
                                                          width: 24.0,
                                                          height: 24.0,
                                                        ),
                                                      ),
                                                      Reaction(
                                                          title: Text("Sad"),
                                                          icon:
                                                              SvgPicture.asset(
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
                                                                      .postList[
                                                                          index]
                                                                      .postReaction) ==
                                                              ""
                                                          ? Icon(
                                                              Icons
                                                                  .thumb_up_alt_outlined,
                                                              color: Colors
                                                                  .black54,
                                                            )
                                                          : controller.checkCurrentUserReaction(controller
                                                                      .postList[
                                                                          index]
                                                                      .postReaction) !=
                                                                  " "
                                                              ? SvgPicture
                                                                  .asset(
                                                                  controller.checkCurrentUserReaction(controller
                                                                      .postList[
                                                                          index]
                                                                      .postReaction),
                                                                  width: 24.0,
                                                                  height: 24.0,
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .thumb_up,
                                                                  color: Colors
                                                                      .blueAccent,
                                                                ),
                                                    ),
                                                    boxItemsSpacing: 8.0,
                                                    boxPadding:
                                                        EdgeInsets.all(4.0),
                                                    boxAlignment:
                                                        Alignment.bottomLeft,
                                                    boxDuration: const Duration(
                                                        milliseconds: 100),
                                                  ),
                                                  controller.postList[index]
                                                          .postReaction.isEmpty
                                                      ? Text(
                                                          "Like",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                        )
                                                      : Text(
                                                          " ${controller.postList[index].postReaction.length} like",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade500,
                                                          ),
                                                        ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Icon(
                                                    Icons.share_outlined,
                                                    color: Colors.black54,
                                                  ),
                                                  Text(
                                                    "Share",
                                                    style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              //comment button
                                              GestureDetector(
                                                onTap: () async {
                                                  Get.to(CommentView(controller
                                                      .postList[index].id));
                                                  // await controller
                                                  //     .requestForCommentListOfPost(
                                                  //         controller
                                                  //             .postList[index]
                                                  //             .id);
                                                  // showCommentBottomSheet(
                                                  //     context,
                                                  //     controller
                                                  //         .postList[index]);
                                                },
                                                child: Column(
                                                  children: [
                                                    Icon(
                                                      Icons.comment_outlined,
                                                      color: Colors.black54,
                                                    ),
                                                    controller.postList[index]
                                                            .postComment.isEmpty
                                                        ? Text(
                                                            "Comment",
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade400,
                                                            ),
                                                          )
                                                        : Text(
                                                            "${controller.postList[index].postComment.length} comment",
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade500,
                                                            )),
                                                  ],
                                                ),
                                              ),
                                              controller.postList[index].type !=
                                                          "text" ||
                                                      controller.postList[index]
                                                              .content !=
                                                          null ||
                                                      controller.postList[index]
                                                              .content !=
                                                          "https://sritsolution.com/hello/"
                                                  ? GestureDetector(
                                                      onTap: () async {
                                                        if (controller
                                                                .postList[index]
                                                                .type ==
                                                            "img") {
                                                          controller
                                                              .downloadFile(
                                                                  controller
                                                                      .postList[
                                                                          index]
                                                                      .content);
                                                          showDownloadingBottomSheet(
                                                              context,
                                                              controller);
                                                          controller
                                                              .fileDownloadingPer
                                                              .value = "0%";
                                                        }
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.save_alt,
                                                            color:
                                                                Colors.black54,
                                                          ),
                                                          Text(
                                                            "Save",
                                                            style: TextStyle(
                                                              color: Colors.grey
                                                                  .shade400,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : SizedBox()
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
                                              0,
                                              // horizontal, move right 10
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
                          Container(child: Center(child: Text('NearBy'))),
                          Container(child: Center(child: Text('Video'))),
                          Container(child: Center(child: Text('Follow'))),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  showDownloadingBottomSheet(context, HomeController controller) {
    showModalBottomSheet(
        backgroundColor: AppColors.themeColor,
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 16.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                  child: Obx(() {
                    return Row(
                      children: [
                        Text(
                          controller.fileDownloadingStatus.value,
                          style: TextStyle(color: Colors.white, fontSize: 18.0),
                        ),
                        Spacer(),
                        Expanded(
                          child: Text(controller.fileDownloadingPer.value,
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        });
  }
}
