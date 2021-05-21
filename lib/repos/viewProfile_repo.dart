import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ViewProfileModel.dart';

Future<DataProfile> viewProfile(String userId) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}myprofile';
  var client = http.Client();

  var response = await client.post(
    url,
    body: {'user': userId},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String jsonString = response.body;

    return responseModelFromJson(jsonString).data;
  } else
    return null;
}
