// To parse this JSON data, do
//
//     final responseTagModel = responseTagModelFromJson(jsonString);

import 'dart:convert';

ResponseTagModel responseTagModelFromJson(String str) => ResponseTagModel.fromJson(json.decode(str));

String responseTagModelToJson(ResponseTagModel data) => json.encode(data.toJson());

class ResponseTagModel {
  ResponseTagModel({
    this.message,
    this.responseCode,
    this.status,
  });

  String message;
  String responseCode;
  bool status;

  factory ResponseTagModel.fromJson(Map<String, dynamic> json) => ResponseTagModel(
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
