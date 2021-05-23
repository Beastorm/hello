import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;

import '../models/ViewProfileModel.dart';

Future<DataProfile> viewProfile(String userId) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}myprofile';
  var client = http.Client();
  print('............userid: $userId');

  var response = await client.post(
    url,
    body: {'user': userId},
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    String jsonString = response.body;
    //print('............userid: $userId, response in provider ${responseModelFromJson(jsonString).data.personal.name}');

    return responseModelFromJson(jsonString).data;
  } else
    return null;
}


Future<ResponseModel> addCoverPhoto(String userId, var imageFile) async {
  final String url = '${GlobalConfiguration().getValue('base_url')}mycoverpictureedit';

  print('Add chapter controller baseurl  $url');

  var request = http.MultipartRequest('POST', Uri.parse(url));
  request.fields['id'] = userId;
  request.files.add(
      await http.MultipartFile.fromPath('item_image', imageFile.toString()));
  var response = await request.send();
  print('Response stream: ${response.stream}');
  print('Response status code: ${response.statusCode}');
  final res = await http.Response.fromStream(response);
  print('Response body: ${res.body}');

  if(response == 200){
    return responseModelFromJson(res.body);
  }else{
    return responseModelFromJson(res.body);
  }
}
