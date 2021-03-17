import 'package:flutter/material.dart';
import 'package:hello/CommonModules/AppColors.dart';

class RegisterScreen extends StatelessWidget {
  AppColors appColors = AppColors();

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
                      height: 45.0,
                    )
                  ],
                ),

                //Email TextField
                Card(
                  shadowColor: AppColors.themeColor,
                  elevation: 4.0,
                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                  child: Container(
                    child: Column(
                      children: [
                        Form(
                          // key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 50,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 50.0),
                                child: TextFormField(
                                    //  controller: loginController.emailTextController,
                                    decoration: InputDecoration(
                                  hintText: 'Enter name',
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w600,
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
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    //controller: loginController.passwordTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter email',
                                      labelText: 'Email',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
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
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    //controller: loginController.passwordTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter mobile',
                                      labelText: 'Mobile',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                        // light
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),
                              //password TextField
                              Container(
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    //controller: loginController.passwordTextController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter password',
                                      labelText: 'Password',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                        // light
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),
                              //confirm TextField
                              Container(
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    //controller: loginController.passwordTextController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Enter confirm password',
                                      labelText: 'Confirm Password',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                        // light
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),

                              //Address TextField
                              Container(
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: TextFormField(
                                    //controller: loginController.passwordTextController,
                                    decoration: InputDecoration(
                                      hintText: 'Enter city',
                                      labelText: 'City',
                                      labelStyle: TextStyle(
                                        fontSize: 15,
                                        color: AppColors.themeColor,
                                        fontWeight: FontWeight.w600,
                                        // light
                                        fontStyle: FontStyle.normal,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: AppColors.themeColor)),
                                    )),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: 35.0, right: 35.0, top: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: 110.0,
                                      height: 48,
                                      child: TextFormField(
                                          //controller: loginController.passwordTextController,
                                          decoration: InputDecoration(
                                        hintText: 'Enter age',
                                        labelText: 'Age',
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.themeColor,
                                          fontWeight: FontWeight.w600,
                                          // light
                                          fontStyle: FontStyle.normal,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: AppColors.themeColor)),
                                      )),
                                    ),
                                    Container(
                                      width: 110.0,
                                      height: 48,
                                      child: TextFormField(
                                          //controller: loginController.passwordTextController,
                                          decoration: InputDecoration(
                                        hintText: 'Enter age',
                                        labelText: 'Age',
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.themeColor,
                                          fontWeight: FontWeight.w600,
                                          // light
                                          fontStyle: FontStyle.normal,
                                        ),
                                        border: OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: AppColors.themeColor)),
                                      )),
                                    ),
                                  ],
                                ),
                              ),

                              //Email TextField
                            ],
                          ),
                        ),

//Login button
                        Card(
                          shadowColor: AppColors.themeColor,
                          elevation: 6.0,
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 50.0, bottom: 30.0),
                          child: Container(
                            height: 40,
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
                                  // if(_formKey.currentState.validate()){
                                  //
                                  //   loginController.getLoginFormValue();
                                  //
                                  // }

                                  // Get.offAll(HomePage());

                                  // print('Email: '+.text+" "+'Password: '+_passwordTextController.text);
                                }),
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
                            )),
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
}
