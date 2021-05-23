import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

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
  print(response.statusCode);
  if (response.statusCode == 200) {
    return true;
  } else
    return false;
}

Future<bool> followerList(String userId) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow';

  var client = http.Client();
  final msg = jsonEncode({
    "userid": userId,
  });
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

Future<List<FollowData>> followedListByCurrentUser(String followBy) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}follow_by';
  var client = http.Client();
  final msg = jsonEncode({
    "follow_by": followBy,
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
