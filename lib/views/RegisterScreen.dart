import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/register_controller.dart';
import '../style/AppColors.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var _formKey = GlobalKey<FormState>();
  final RegisterController _registerController = Get.put(RegisterController());
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (Stack(
        children: [
          Positioned(
            left: 0.0,
            child: Image.asset('assets/images/backbg.png', height: 120.0),
          ),
          Container(
            margin: EdgeInsets.only(top: 25.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 72.0,
                    )
                  ],
                ),
                Card(
                  shadowColor: AppColors.themeColor.withOpacity(0.5),
                  elevation: 1.0,
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 40.0),
                  child: Container(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 50.0),
                                child: TextFormField(
                                    controller:
                                        _registerController.nameController,
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

                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                  controller:
                                      _registerController.emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  //onSaved: (input) => _con.user.name = input,
                                  validator: (input) => !input.contains("@")
                                      ? "invalid email Format"
                                      : null,
                                  decoration: InputDecoration(
                                    hintText: 'Enter email',
                                    labelText: 'Email',
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
                              //Mobile TextField
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                  controller:
                                      _registerController.mobileController,
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
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    controller:
                                        _registerController.pwdController,
                                    validator: (input) => input.length < 8
                                        ? "should be more than 7 characters"
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'Enter password',
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.themeColor,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),

                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    controller:
                                        _registerController.cityController,
                                    validator: (input) => input.length < 1
                                        ? "should_be_not_empty"
                                        : null,
                                    decoration: InputDecoration(
                                      hintText: 'Enter city',
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.themeColor,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),
                              InkWell(
                                onTap: () {
                                  _selectDate(context);
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
                                        fontSize: 14.0,
                                        color: AppColors.themeColor),
                                    textAlign: TextAlign.start,
                                    enabled: false,
                                    keyboardType: TextInputType.datetime,
                                    controller:
                                        _registerController.dobController,
                                    decoration: InputDecoration(
                                      hintText: "Date Of Birth",
                                      labelText: "DOB",
                                      labelStyle: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.themeColor,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      contentPadding:
                                          EdgeInsets.only(top: 16.0),
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
                            ],
                          ),
                        ),

//Login button
                        Card(
                          shadowColor: AppColors.themeColor,
                          elevation: 1.0,
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 50.0, bottom: 30.0),
                          child: Container(
                            height: 40,
                            width: 160.0,
                            child: RaisedButton(
                              color: AppColors.themeColor,
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.0,
                                    color: AppColors.white),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _registerController
                                      .requestForRegisterProcess();
                                }
                              },
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 30.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Already have account? '),
                              Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 15.0,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w800),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.subtract(Duration(days: 15 * 365)),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(1940, 1, 13),
        lastDate: selectedDate.subtract(Duration(days: 15 * 365)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _registerController.dobController.text =
            DateFormat.yMd().format(selectedDate);
      });
  }
}
