import 'dart:convert';
import 'dart:io';

import 'package:get_storage/get_storage.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:hello/models/register_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decoder/jwt_decoder.dart';

Future<bool> loginProcess(String email, String pwd) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}login';
  Map<String, dynamic> user;
  var client = http.Client();
  final msg = jsonEncode(
    {"email": email, "password": pwd},
  );
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> decodedToken =
        JwtDecoder.decode(response.headers["data"]);

    user = decodedToken["data"]["data"][0];

    print(jsonEncode(decodedToken["data"]["data"][0]["name"]));

    setCurrentUser(
        user["email"], user["name"], user["mobile"], user["image"], user["id"]);
    return userRegisterResponseFromJson(response.body).status;
  }
  return userRegisterResponseFromJson(response.body).status;
}

void setCurrentUser(String email, String name, String mobile, String profilePic,
    String userId) {
  final pref = GetStorage();
  pref.write("isLogin", true);
  pref.write("name", name);
  pref.write("email", email);
  pref.write("mobile", mobile);
  // pref.write("veg", veg);
  pref.write("pic", profilePic);
  pref.write("userId", userId);
  // print(name);
  // print(email);
  // print(mobile);
  // print(profilePic);
  // print(veg);
}
