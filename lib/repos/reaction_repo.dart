import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import '../models/reaction_model.dart';
import 'package:http/http.dart' as http;

Future<List<Datum>> getReactions() async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}reactionList';

  var client = http.Client();

  var response = await client.post(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    if (reactionModelFromJson(response.body).status)
      return reactionModelFromJson(response.body).data;
    else
      return reactionModelFromJson(response.body).data;
  } else
    return null;
}

Future<bool> sendReaction(
    String userId, String reactionId, String postId) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}postReactions';

  var client = http.Client();
  final msg =
      jsonEncode({"post": postId, "user": userId, "reaction": reactionId});
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

editReaction(
    String userId, String parent, String postId, String content) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}postReactions';

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

removeReaction(String postId) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}postReactions';

  var client = http.Client();
  final msg = jsonEncode({"id": postId});
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
