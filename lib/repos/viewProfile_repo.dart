import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ViewProfileModel.dart';

Future<DataProfile> viewProfile(String userId) async {

  final String url = '${GlobalConfiguration().getValue('base_url')}myprofile';
  var client = http.Client();
  final msg = jsonEncode(
    {
      "user": userId,
    },
  );
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String jsonString = response.body;

    return viewProfileModelFromJson(jsonString).data;
  } else
    return null;
}
