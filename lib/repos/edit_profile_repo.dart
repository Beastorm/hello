import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import '../models/EditProfileModel.dart';
import 'package:path/path.dart';
Future<int> editProfileProcess(
    String id, String mobile, String name, String dob, String city) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}myprofileedit';
  var client = http.Client();
  final msg = jsonEncode(
    {
      "id": id,
      "email": null,
      "name": name,
      "mobile": mobile,
      "gender": null,
      "age": dob,
      "address": city
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

editUserImage(File imageFile, String userId) async {
  final String url =
      '${GlobalConfiguration().getValue('base_url')}myprofilepictureedit';

  var stream =
  new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();

  var uri = Uri.parse(url);

  var request = new http.MultipartRequest("POST", uri);
  request.fields['id'] = userId;
  var multipartFile = new http.MultipartFile('item_image', stream, length,
      filename: basename(imageFile.path));
  //contentType: new MediaType('image', 'png'));
  request.files.add(multipartFile);
  var response = await request.send();
  print(response.statusCode);
  response.stream.transform(utf8.decoder).listen((value) {
    print(value);
  });
}
