import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:hello/models/register_response_model.dart';
import 'package:http/http.dart' as http;

Future<int> registerProcess(String mobile, String email, String name,
    String pwd, String city, String age, String address) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}register';
  var client = http.Client();
  final msg = jsonEncode(
    {
      "name": name,
      "email": email,
      "mobile": mobile,
      "password": pwd,
      "gender": city,
      "age": age,
      "address": address
    },
  );
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  print(userRegisterResponseFromJson(response.body).status);
  try {
    if (response.statusCode == 200) {
      if (userRegisterResponseFromJson(response.body).status) {
        return 0;
      } else {
        return 1;
      }
    } else
      return -1;
  } on Exception catch (e) {
    print(e);
    return -1;
  }
}
