import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:global_configuration/global_configuration.dart';
import '../models/post_model.dart';
import '../models/view_response_model.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

Future<PostResponseModel> createPost(
  String userId,
  String postType,
  String description,
  String bgColor,
  String topic,
  String location,
  String tag,
  String postVisibility,
  String commentVisibility,
  String isShareable,
  String isSaveAllowed,
  String isAllowedInNearbyChannel,
  String status,
) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}posts';

  var client = http.Client();
  final msg = jsonEncode(
    {
      "user": userId,
      "type": postType,
      "description": description,
      "color": bgColor,
      "topic": topic,
      "location": location,
      "tag": tag,
      "is_post_view": postVisibility,
      "is_post_comment": commentVisibility,
      "is_share": isShareable,
      "is_save": isSaveAllowed,
      "is_nearby_show ": isAllowedInNearbyChannel,
      "status": status,
    },
  );
  var response = await client.post(
    url,
    headers: {HttpHeaders.contentTypeHeader: 'application/json'},
    body: msg,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    return postResponseModelFromJson(response.body);
  } else
    return postResponseModelFromJson(response.body);
}

Future<List<PostData>> viewPost() async {
  final String url = '${GlobalConfiguration().getValue('base_url')}posts';
  var client = http.Client();
  var response = await client.post(url);
  print(response.statusCode);
  if (response.statusCode == 200) {
    if (postModelFromJson(response.body).status) {
      return postModelFromJson(response.body).data;
    }
    return null;
  } else
    return null;
}

uploadPostFile(File file, String postId, String postType) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}postsImageUpload';
  var multipartFile;
  var uri = Uri.parse(url);
  var request = http.MultipartRequest("POST", uri);
  request.fields['id'] = postId;

  if (postType == "img") {
    var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
    var length = await file.length();
    multipartFile = http.MultipartFile('item_image', stream, length,
        filename: basename(file.path));
  } else {
    multipartFile = await http.MultipartFile.fromPath("item_image", file.path);
  }

  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
  //https://dev.to/carminezacc/advanced-flutter-networking-part-1-uploading-a-file-to-a-rest-api-from-flutter-using-a-multi-part-form-data-post-request-2ekm
}
