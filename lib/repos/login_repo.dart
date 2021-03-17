import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:hello/models/register_response_model.dart';
import 'package:http/http.dart' as http;

Future<bool> loginProcess(String email, String pwd) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}login';
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
    return userRegisterResponseFromJson(json.decode(response.body)).status;
  }
  return userRegisterResponseFromJson(json.decode(response.body)).status;
}
