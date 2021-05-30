import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ViewProfileModel.dart';
import '../models/follow_model.dart';

Future<bool> followAUser(String userId, String followBy) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow';

  var client = http.Client();
  final msg = jsonEncode({"userid": userId, "follow_by": followBy});
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else
    return false;
}

Future<bool> unFollowAUser(String userId, String followBy) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow';
  var client = http.Client();
  final msg = jsonEncode({"userid": userId, "follow_by": followBy});
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  if (response.statusCode == 200) {
    print(responseModelFromJson(response.body).message);
    return true;
  } else
    return false;
  print(response.statusCode);
}

Future<List<FollowData>> followerListApi(String userId) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow';

  var client = http.Client();
  final msg = jsonEncode({
    "follow_by": userId,
  });
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return followModelFromJson(response.body).data;
  } else
    return followModelFromJson(response.body).data;
}

Future<List<FollowData>> followingApi(String followBy) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow';
  var client = http.Client();
  final msg = jsonEncode({
    "userid": followBy,
  });
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  try {
    if (response.statusCode == 200) {
      return followModelFromJson(response.body).data;
    } else
      return null;
  } on Exception catch (e) {
    return null;
  }
}
