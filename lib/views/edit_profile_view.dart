import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hello/controllers/home_controller.dart';
import 'package:hello/controllers/register_controller.dart';
import 'package:hello/style/AppColors.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  final HomeController controller = Get.put(HomeController());
  final RegisterController _registerController = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.themeColor,
          leading: Icon(Icons.backspace_outlined),
          title: Text('Edit Profile')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Container(
                  child: controller.postList[0].user[0].image == ""
                      ? Icon(
                    Icons.account_circle_rounded,
                    size: 80,
                    color: Colors.grey.shade400,
                  )
                      : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                      imageUrl: controller.postList[0].user[0].image,
                      placeholder: (context, url) =>
                          Image.asset(
                            'assets/images/loading.gif',
                            fit: BoxFit.cover,
                          ),
                      errorWidget: (context, url, error) =>
                          Icon(
                            Icons.account_circle_rounded,
                            size: 50.0,
                            color: Colors.grey.shade400,
                          ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Edit profile picture', style: TextStyle(
                        color: Colors.lightBlue, fontWeight: FontWeight.w300),),
                    Icon(Icons.edit),


                  ],
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 50.0),
                          child:
                          TextFormField(
                              controller:
                              _registerController.nameController,
                              keyboardType: TextInputType.name,
                              validator: (input) =>
                              input.length < 3
                                  ? "should_be_more_than_3_chars"
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'Enter name',
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.themeColor,

                                  // light
                                  fontStyle: FontStyle.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.themeColor)),
                              )),
                        ),

                        //Email TextField
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                            controller:
                            _registerController.emailController,
                            keyboardType: TextInputType.emailAddress,
                            //onSaved: (input) => _con.user.name = input,
                            validator: (input) =>
                            !input.contains("@")
                                ? "invalid email Format"
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Enter email',
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.themeColor,

                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: AppColors.themeColor)),
                            ),
                          ),
                        ),
                        //Mobile TextField
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                            controller:
                            _registerController.mobileController,
                            keyboardType: TextInputType.phone,
                            validator: (input) =>
                            input.length != 10
                                ? "should_be_equal_to_10_digits"
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Enter mobile',
                              labelText: 'Mobile',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.themeColor,

                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                borderSide: new BorderSide(
                                    color: AppColors.themeColor),
                              ),
                            ),
                          ),
                        ),
                        //password TextField
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                              controller:
                              _registerController.pwdController,
                              validator: (input) =>
                              input.length < 8
                                  ? "should be more than 7 characters"
                                  : null,
                              //obscureText: controller.hidePassword.value,

                              decoration: InputDecoration(
                                hintText: 'Enter password',
                                labelText: 'Password',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.themeColor,

                                  // light
                                  fontStyle: FontStyle.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.themeColor)),
                              )),
                        ),

                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                              controller:
                              _registerController.cityController,
                              validator: (input) =>
                              input.length < 1
                                  ? "should_be_not_empty"
                                  : null,
                              decoration: InputDecoration(
                                hintText: 'Enter city',
                                labelText: 'City',
                                labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.themeColor,

                                  // light
                                  fontStyle: FontStyle.normal,
                                ),
                                border: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color: AppColors.themeColor)),
                              )),
                        ),
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                            controller: _registerController.ageController,
                            keyboardType: TextInputType.number,
                            validator: (input) =>
                            input.length < 1
                                ? "should be not be Empty"
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Enter DOB',
                              labelText: 'eg. 25/06/1995',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.themeColor,

                                // light
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: AppColors.themeColor)),
                            ),
                          ),
                        ),
                        Container(
                          height: 44,
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(

                            controller:
                            _registerController.addressController,
                            validator: (input) =>
                            input.length < 1
                                ? "should_be_not_empty"
                                : null,
                            decoration: InputDecoration(
                              hintText: 'Enter Address',
                              labelText: 'address',
                              labelStyle: TextStyle(
                                fontSize: 14,
                                color: AppColors.themeColor,
                                fontStyle: FontStyle.normal,
                              ),
                              border: OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: AppColors.themeColor)),
                            ),
                          ),
                        ),

                        //Email TextField
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}