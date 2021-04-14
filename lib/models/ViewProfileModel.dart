// To parse this JSON data, do
//
//     final viewProfileModel = viewProfileModelFromJson(jsonString);

import 'dart:convert';

ViewProfileModel viewProfileModelFromJson(String str) => ViewProfileModel.fromJson(json.decode(str));

String viewProfileModelToJson(ViewProfileModel data) => json.encode(data.toJson());

class ViewProfileModel {
  ViewProfileModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  DataProfile data;

  factory ViewProfileModel.fromJson(Map<String, dynamic> json) => ViewProfileModel(
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
  });

  String name;
  String mobile;
  String email;
  String type;
  String image;
  String address;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    name: json["name"] == null ? null : json["name"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    email: json["email"] == null ? null : json["email"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
    address: json["address"] == null ? null : json["address"],
  );

  Map<String, dynamic> toJson() => {
    "name": name == null ? null : name,
    "mobile": mobile == null ? null : mobile,
    "email": email == null ? null : email,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
    "address": address == null ? null : address,
  };
}
