import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:hello/models/post_model.dart';
import 'package:http/http.dart' as http;

Future<PostModel> getComments(String postId) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}comments';

  var client = http.Client();
  final msg = jsonEncode({"post": postId});
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return null;
  } else
    return null;
}

Future<PostModel> sendComment(
    String userId, String parent, String postId, String content) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}comments';

  var client = http.Client();
  final msg = jsonEncode(
      {"post": postId, "parent": parent, "user": userId, "content": content});
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return null;
  } else
    return null;
}

Future<PostModel> editComment(
    String userId, String parent, String postId, String content) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}comments';

  var client = http.Client();
  final msg = jsonEncode(
      {"post": postId, "parent": parent, "user": userId, "content": content});
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return null;
  } else
    return null;
}
