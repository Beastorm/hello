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
  });

  String message;
  String responseCode;
  bool status;

  factory UserRegisterResponse.fromJson(Map<String, dynamic> json) => UserRegisterResponse(
    message: json["message"] == null ? null : json["message"],
    responseCode: json["response_code"] == null ? null : json["response_code"],
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "response_code": responseCode == null ? null : responseCode,
    "status": status == null ? null : status,
  };
}
