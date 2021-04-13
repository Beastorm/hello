// To parse this JSON data, do
//
//     final editProfileModel = editProfileModelFromJson(jsonString);
import 'dart:convert';

EditProfileModel editProfileModelFromJson(String str) => EditProfileModel.fromJson(json.decode(str));

String editProfileModelToJson(EditProfileModel data) => json.encode(data.toJson());

class EditProfileModel {
  EditProfileModel({
    this.message,
    this.responseCode,
    this.status,
  });

  String message;
  String responseCode;
  bool status;

  factory EditProfileModel.fromJson(Map<String, dynamic> json) => EditProfileModel(
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
