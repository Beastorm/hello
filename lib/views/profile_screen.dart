import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hello/controllers/home_controller.dart';
import 'package:hello/style/AppColors.dart';
import 'edit_profile_view.dart';


class ProfileScreen extends StatelessWidget {
  final HomeController controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                    width: double.infinity,
                    height: 170.0,
                    child: Container(
                      color: Colors.pinkAccent,
                    )),
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30),
                          Text('Sam Smith'),
                          Text('sam@gmail.com',
                              style:
                              TextStyle(color: Colors.black54, fontSize: 13)),

                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  child: Row(
                    children: [
                      SizedBox(width: 40),
                      Expanded(child: Text('Following(0)')),
                      Expanded(child: Text('Followers(0)')),
                      Expanded(child: Text('Group(0)')),
                    ],
                  ),
                ),

              ],
            ),
            Positioned(
              top: 140.0,
              left: 15.0,
              child: controller.postList[0].user[0].image == ""
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
                  imageUrl: controller.postList[0].user[0].image,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/loading.gif',
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(
                    Icons.account_circle_rounded,
                    size: 48.0,
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
                    child: Text('Edit Profile', style: TextStyle(fontSize: 12),),
                  ),
                )),
            Positioned(
                top: 12,
                left: 15,
                child: Icon(Icons.arrow_back)

            ),

          ],
        ),
      ),
    );
  }
}
