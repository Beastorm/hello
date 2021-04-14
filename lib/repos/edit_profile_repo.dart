import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:hello/models/EditProfileModel.dart';
import 'package:http/http.dart' as http;

Future<int> editProfileProcess(String id, String mobile, String name, String city, String age, String address) async {
  print('edit value api: id: $id, mobile: $mobile, name: $name, city: $city, age: $age, adress: $address');

  final String url = '${GlobalConfiguration().getValue('base_url')}myprofileedit';
  var client = http.Client();
  final msg = jsonEncode(
    {
      "id": id,
      "name": name,
      "mobile": mobile,
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
  print(editProfileModelFromJson(response.body).status);
  try {
    if (response.statusCode == 200) {
      if (editProfileModelFromJson(response.body).status) {
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
