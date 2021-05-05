import 'package:Milto/controllers/home_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/EditProfileController.dart';
import '../style/AppColors.dart';

// ignore: must_be_immutable
class EditProfile extends StatelessWidget {
  var _formKey = GlobalKey<FormState>();
  final HomeController homeController = Get.find<HomeController>();

  final EditProfileController editProfileController =
      Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.themeColor, title: Text('Edit Profile')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                SizedBox(height: 20),
                Obx(
                  () => Container(
                    child: editProfileController.isFileSelected.value == false
                        ? ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            child: CachedNetworkImage(
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                              imageUrl: editProfileController.pref.read("pic"),
                              placeholder: (context, url) => Image.asset(
                                'assets/images/loading.gif',
                                fit: BoxFit.cover,
                              ),
                              errorWidget: (context, url, error) => Icon(
                                Icons.account_circle_rounded,
                                size: 50.0,
                                color: Colors.grey.shade400,
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(80)),
                            child: Image.asset(
                              editProfileController.file.value.path,
                              fit: BoxFit.cover,
                              width: 80,
                              height: 80,
                            ),
                          ),
                  ),
                ),
                RaisedButton.icon(
                  color: Colors.grey.shade100,
                  elevation: 0.0,
                  onPressed: () async {
                    await editProfileController.requestForImageUpload();
                  },
                  icon: Icon(Icons.edit),
                  label: Text(
                    'Change profile picture',
                    style: TextStyle(color: AppColors.themeColor),
                  ),
                ),
                SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 50.0),
                          child: TextFormField(
                              controller: editProfileController.nameController,
                              keyboardType: TextInputType.name,
                              validator: (input) => input.length < 3
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

                        //Mobile TextField
                        Container(
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                            controller: editProfileController.mobileController,
                            keyboardType: TextInputType.phone,
                            validator: (input) => input.length != 10
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
                                borderSide:
                                    new BorderSide(color: AppColors.themeColor),
                              ),
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(
                              left: 35.0, right: 35.0, top: 10.0),
                          child: TextFormField(
                              controller: editProfileController.cityController,
                              validator: (input) => input.length < 1
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
                        InkWell(
                          onTap: () {
                            _selectDate(
                              context,
                            );
                          },
                          child: Container(
                            height: 50,
                            margin: EdgeInsets.only(
                                left: 35.0, right: 35.0, top: 10.0),
                            child: TextFormField(
                              validator: (input) => input.length < 1
                                  ? "should_be_not_empty"
                                  : null,
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.black87),
                              textAlign: TextAlign.start,
                              enabled: false,
                              keyboardType: TextInputType.datetime,
                              controller: editProfileController.dobController,
                              decoration: InputDecoration(
                                hintText: "Date Of Birth",
                                disabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                contentPadding: EdgeInsets.only(top: 16.0),
                                prefixIcon: Icon(
                                  Icons.calendar_today_rounded,
                                  color: AppColors.themeColor,
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          ),
                        ),

                        Card(
                          shadowColor: AppColors.themeColor,
                          elevation: 0.0,
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 30.0, bottom: 30.0),
                          child: Container(
                            height: 40,
                            width: 160.0,
                            child: RaisedButton(
                              color: AppColors.themeColor,
                              child: Text(
                                'Update',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.0,
                                    color: AppColors.white),
                              ),
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  await editProfileController
                                      .requestForEditProfile();
                                }
                              },
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

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: editProfileController.selectedDate.value
            .subtract(Duration(days: 15 * 365)),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1940, 1, 13),
        lastDate: editProfileController.selectedDate.value
            .subtract(Duration(days: 15 * 365)));
    if (picked != null) {
      editProfileController.selectedDate.value = picked;
      editProfileController.dobController.text =
          DateFormat.yMd().format(editProfileController.selectedDate.value);
    }
  }
}
