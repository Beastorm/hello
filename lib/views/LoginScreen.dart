import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

import '../style/AppColors.dart';
import 'RegisterScreen.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginController _loginController = Get.put(LoginController());

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
            margin: EdgeInsets.only(top: 56.0),
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

                //Email TextField
                Card(
                  shadowColor: AppColors.themeColor.withOpacity(0.5),
                  elevation: 1.0,
                  margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0),
                  child: Container(
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 50.0),
                                child: TextFormField(
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (input) => !input.contains("@")
                                      ? "invalid email Format"
                                      : null,
                                  controller: _loginController.emailController,
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
                                  ),
                                ),
                              ),

                              //Password TextField
                              Container(
                                height: 48,
                                margin: EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 20.0),
                                child: TextFormField(
                                  validator: (input) => input.length < 8
                                      ? "should_be_more_than_7_chars"
                                      : null,
                                  controller: _loginController.pwdController,
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, right: 35.0),
                              child: Text(
                                'Forgot Password ?',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: AppColors.themeColor,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
//Login button
                        Card(
                          shadowColor: AppColors.themeColor,
                          elevation: 2.0,
                          margin: EdgeInsets.only(
                              left: 40.0, right: 40.0, top: 50.0, bottom: 30.0),
                          child: Container(
                            height: 40,
                            width: 160.0,
                            child: RaisedButton(
                              color: AppColors.themeColor,
                              child: Text(
                                'LOGIN',
                                style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 12.0,
                                    color: AppColors.white),
                              ),
                              onPressed: () {
                                if (_formKey.currentState.validate()) {
                                  _loginController.requestForLoginProcess();
                                }
                              },
                            ),
                          ),
                        ),

                        InkWell(
                          onTap: () {
                            Get.to(RegisterScreen());
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 30.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Don\'t have account? '),
                                Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: AppColors.themeColor,
                                      fontWeight: FontWeight.w800),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.only(bottom: 30.0, top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                  onTap: () =>
                                      _loginController.handleFacebookLogin(),
                                  child: Image.asset('assets/images/fb.png',
                                      height: 30.0)),
                              GestureDetector(
                                onTap: () =>
                                    _loginController.handleGoogleLoginIn(),
                                child: Image.asset(
                                  'assets/images/google.png',
                                  height: 30.0,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      )),
    );
  }
}
