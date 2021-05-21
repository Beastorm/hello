import 'package:Milto/controllers/home_controller.dart';
import 'package:Milto/style/AppColors.dart';
import 'package:Milto/views/Comment_rply.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommentView extends StatelessWidget {
  String postId;
  final box = GetStorage();
  HomeController homeController = Get.put(HomeController());
  var _formKey = GlobalKey<FormState>();

  CommentView(this.postId);

  @override
  Widget build(BuildContext context) {
    String userId = box.read('userId');
    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 24),
        width: double.infinity,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              flex: 12,
              child: Form(
                key: _formKey,
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  validator: (input) =>
                      input.isEmpty ? "Please write something" : null,
                  controller: homeController.commentContentController,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                    hintText: 'Write Something...',
                    hintStyle: TextStyle(color: Colors.grey.shade400),
                    labelStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(24.0)),
                      borderSide: new BorderSide(color: AppColors.themeColor),
                    ),
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
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    homeController.requestForSendComment(postId, "0");
                    homeController.requestForCommentListOfPost(postId);
                  }
                },
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Comments'),
      ),
      body: GetX<HomeController>(initState: (context) {
        homeController.requestForCommentListOfPost(postId);
      }, builder: (controller) {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Container(
            margin: EdgeInsets.only(bottom: 66, left: 10, right: 10),
            child: GetX<HomeController>(builder: (controller) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: controller.commentFilter.length,
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
                              children: [
                                controller.commentFilter[index].user[0].image ==
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
                                              .commentFilter[index].user[0].image,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/images/loading.gif',
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
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
                                Text(
                                  controller.commentFilter[index].user[0].name,
                                  style: TextStyle(
                                      fontSize: 14.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w400),
                                ),
                                Spacer(),
                              ],
                            ),
                            SizedBox(height: 10),
                            //controller.commentList[index].content
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 6, bottom: 10),
                              child: RichText(
                                  text: TextSpan(
                                      text:
                                          controller.commentFilter[index].content,
                                      style: TextStyle(color: Colors.black))),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(CommentReply(controller.commentFilter[index].id, controller.commentFilter[index].content,
                                    postId));
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, bottom: 10, top: 6),
                                child: Text(
                                  'Reply',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          );
        }
      }),
    );
  }
}

// Padding(
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Padding(
//               padding:
//               EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 5,
//                     child: Form(
//                       key: _formKey,
//                       child: TextFormField(
//                         keyboardType: TextInputType.multiline,
//                         validator: (input) =>
//                         input.isEmpty ? "Please write something" : null,
//                         controller:
//                         _homeController.commentContentController,
//                         decoration: InputDecoration(
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 16.0, vertical: 0.0),
//                           hintText: 'Write Something...',
//                           hintStyle: TextStyle(color: Colors.grey.shade400),
//                           labelStyle: TextStyle(
//                             fontSize: 15,
//                             color: Colors.grey,
//                             fontStyle: FontStyle.normal,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(24.0)),
//                             borderSide:
//                             new BorderSide(color: AppColors.themeColor),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: IconButton(
//                       icon: Icon(
//                         Icons.send,
//                         color: AppColors.themeColor,
//                       ),
//                       onPressed: () async {
//                         if (_formKey.currentState.validate()) {
//                           await _homeController.requestForSendComment(
//                               postData.id, "0");
//                         }
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(height: 10),
