// To parse this JSON data, do
//
//     final responseModel = responseModelFromJson(jsonString);

import 'dart:convert';

ResponseModel responseModelFromJson(String str) => ResponseModel.fromJson(json.decode(str));

String responseModelToJson(ResponseModel data) => json.encode(data.toJson());

class ResponseModel {
  ResponseModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  DataProfile data;

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    message: json["message"] == null ? null : json["message"],
    responseCode: json["response_code"] == null ? null : json["response_code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : DataProfile.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "response_code": responseCode == null ? null : responseCode,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class DataProfile {
  DataProfile({
    this.personal,
  });

  Personal personal;

  factory DataProfile.fromJson(Map<String, dynamic> json) => DataProfile(
    personal: json["personal"] == null ? null : Personal.fromJson(json["personal"]),
  );

  Map<String, dynamic> toJson() => {
    "personal": personal == null ? null : personal.toJson(),
  };
}

class Personal {
  Personal({
    this.name,
    this.mobile,
    this.email,
    this.type,
    this.image,
    this.address,
    this.language,
    this.gender,
    this.age,
    this.cover,
  });

  String name;
  String mobile;
  String email;
  String type;
  String image;
  String address;
  String language;
  String gender;
  String age;
  String cover;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    name: json["name"] == null ? null : json["name"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    email: json["email"] == null ? null : json["email"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
    address: json["address"] == null ? null : json["address"],
    language: json["language"] == null ? null : json["language"],
    gender: json["gender"] == null ? null : json["gender"],
    age: json["age"] == null ? null : json["age"],
    cover: json["cover"] == null ? null : json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "mobile": mobile == null ? null : mobile,
    "email": email == null ? null : email,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
    "address": address == null ? null : address,
    "language": language == null ? null : language,
    "gender": gender == null ? null : gender,
    "age": age == null ? null : age,
    "cover": cover == null ? null : cover,
  };
}
