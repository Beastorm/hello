// To parse this JSON data, do
//
//     final followModel = followModelFromJson(jsonString);

import 'dart:convert';

FollowModel followModelFromJson(String str) =>
    FollowModel.fromJson(json.decode(str));

String followModelToJson(FollowModel data) => json.encode(data.toJson());

class FollowModel {
  FollowModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  List<FollowData> data;

  factory FollowModel.fromJson(Map<String, dynamic> json) => FollowModel(
        message: json["message"] == null ? null : json["message"],
        responseCode:
            json["response_code"] == null ? null : json["response_code"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<FollowData>.from(
                json["data"].map((x) => FollowData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "response_code": responseCode == null ? null : responseCode,
        "status": status == null ? null : status,
        "data": data == null
            ? null
            : List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class FollowData {
  FollowData({
    this.id,
    this.userid,
    this.followBy,
    this.createdAt,
  });

  String id;
  List<Userid> userid;
  List<FollowBy> followBy;
  DateTime createdAt;

  factory FollowData.fromJson(Map<String, dynamic> json) => FollowData(
        id: json["id"] == null ? null : json["id"],
        userid: json["userid"] == null
            ? null
            : List<Userid>.from(json["userid"].map((x) => Userid.fromJson(x))),
        followBy: json["follow_by"] == null
            ? null
            : List<FollowBy>.from(
                json["follow_by"].map((x) => FollowBy.fromJson(x))),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "userid": userid == null
            ? null
            : List<dynamic>.from(userid.map((x) => x.toJson())),
        "follow_by": followBy == null
            ? null
            : List<dynamic>.from(followBy.map((x) => x.toJson())),
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
      };
}

class FollowBy {
  FollowBy({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.token,
    this.type,
    this.image,
    this.cover,
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
  String cover;
  String address;
  String age;
  String gender;
  String language;
  String logby;
  DateTime date;

  factory FollowBy.fromJson(Map<String, dynamic> json) => FollowBy(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        token: json["token"] == null ? null : json["token"],
        type: json["type"] == null ? null : json["type"],
        image: json["image"] == null ? null : json["image"],
        cover: json["cover"] == null ? null : json["cover"],
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
        "cover": cover == null ? null : cover,
        "address": address == null ? null : address,
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
        "language": language == null ? null : language,
        "logby": logby == null ? null : logby,
        "date": date == null ? null : date.toIso8601String(),
      };
}

class Userid {
  Userid({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.password,
    this.token,
    this.type,
    this.image,
    this.cover,
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
  String cover;
  String address;
  String age;
  String gender;
  String language;
  String logby;
  DateTime date;

  factory Userid.fromJson(Map<String, dynamic> json) => Userid(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        mobile: json["mobile"] == null ? null : json["mobile"],
        password: json["password"] == null ? null : json["password"],
        token: json["token"] == null ? null : json["token"],
        type: json["type"] == null ? null : json["type"],
        image: json["image"] == null ? null : json["image"],
        cover: json["cover"] == null ? null : json["cover"],
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
        "cover": cover == null ? null : cover,
        "address": address == null ? null : address,
        "age": age == null ? null : age,
        "gender": gender == null ? null : gender,
        "language": language == null ? null : language,
        "logby": logby == null ? null : logby,
        "date": date == null ? null : date.toIso8601String(),
      };
}
