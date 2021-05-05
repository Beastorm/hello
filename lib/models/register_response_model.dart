// To parse this JSON data, do
//
//     final userRegisterResponse = userRegisterResponseFromJson(jsonString);

import 'dart:convert';

UserRegisterResponse userRegisterResponseFromJson(String str) => UserRegisterResponse.fromJson(json.decode(str));

String userRegisterResponseToJson(UserRegisterResponse data) => json.encode(data.toJson());

class UserRegisterResponse {
  UserRegisterResponse({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  List<Datum> data;

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) => UserRegisterResponse(
    message: json["message"] == null ? null : json["message"],
    responseCode: json["response_code"] == null ? null : json["response_code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "response_code": responseCode == null ? null : responseCode,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.token,
    this.type,
    this.image,
    this.address,
    this.age,
    this.gender,
    this.language,
    this.logby,
    this.date,
  });

  String id;
  String name;
  String email;
  String mobile;
  String password;
  String token;
  String type;
  String image;
  String address;
  String age;
  String gender;
  String language;
  String logby;
  DateTime date;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    email: json["email"] == null ? null : json["email"],
    mobile: json["mobile"] == null ? null : json["mobile"],
    password: json["password"] == null ? null : json["password"],
    token: json["token"] == null ? null : json["token"],
    type: json["type"] == null ? null : json["type"],
    image: json["image"] == null ? null : json["image"],
    address: json["address"] == null ? null : json["address"],
    age: json["age"] == null ? null : json["age"],
    gender: json["gender"] == null ? null : json["gender"],
    language: json["language"] == null ? null : json["language"],
    logby: json["logby"] == null ? null : json["logby"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "email": email == null ? null : email,
    "mobile": mobile == null ? null : mobile,
    "password": password == null ? null : password,
    "token": token == null ? null : token,
    "type": type == null ? null : type,
    "image": image == null ? null : image,
    "address": address == null ? null : address,
    "age": age == null ? null : age,
    "gender": gender == null ? null : gender,
    "language": language == null ? null : language,
    "logby": logby == null ? null : logby,
    "date": date == null ? null : date.toIso8601String(),
  };
}
