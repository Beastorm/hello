import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import '../models/tag_response_model.dart';
import '../models/tags_model.dart';
import 'package:http/http.dart' as http;

Future<List<TagData>> viewTags() async {
  final String url = '${GlobalConfiguration().getValue('base_url')}tags';

  var client = http.Client();

  var response = await client.post(
    url,
  );

  if (response.statusCode == 200) {
    return tagsModelFromJson(response.body).data;
  }
  return tagsModelFromJson(response.body).data;
}

Future<bool> createTag(String tagName) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}tags';
  final msg = jsonEncode(
    {"name": tagName},
  );
  var client = http.Client();
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );

  if (response.statusCode == 200) {
    return responseTagModelFromJson(response.body).status;
  }
  return responseTagModelFromJson(response.body).status;
}
