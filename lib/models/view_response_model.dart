// To parse this JSON data, do
//
//     final postResponseModel = postResponseModelFromJson(jsonString);

import 'dart:convert';

PostResponseModel postResponseModelFromJson(String str) => PostResponseModel.fromJson(json.decode(str));

String postResponseModelToJson(PostResponseModel data) => json.encode(data.toJson());

class PostResponseModel {
  PostResponseModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  Data data;

  factory PostResponseModel.fromJson(Map<String, dynamic> json) => PostResponseModel(
    message: json["message"] == null ? null : json["message"],
    responseCode: json["response_code"] == null ? null : json["response_code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "response_code": responseCode == null ? null : responseCode,
    "status": status == null ? null : status,
    "data": data == null ? null : data.toJson(),
  };
}

class Data {
  Data({
    this.id,
    this.user,
    this.type,
    this.description,
    this.content,
    this.color,
    this.topic,
    this.location,
    this.tag,
    this.isPostView,
    this.isPostComment,
    this.isShare,
    this.isSave,
    this.isNearbyShow,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String user;
  String type;
  String description;
  String content;
  String color;
  String topic;
  String location;
  String tag;
  String isPostView;
  String isPostComment;
  String isShare;
  String isSave;
  String isNearbyShow;
  String status;
  DateTime createdAt;
  String updatedAt;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : json["user"],
    type: json["type"] == null ? null : json["type"],
    description: json["description"] == null ? null : json["description"],
    content: json["content"] == null ? null : json["content"],
    color: json["color"] == null ? null : json["color"],
    topic: json["topic"] == null ? null : json["topic"],
    location: json["location"] == null ? null : json["location"],
    tag: json["tag"] == null ? null : json["tag"],
    isPostView: json["is_post_view"] == null ? null : json["is_post_view"],
    isPostComment: json["is_post_comment"] == null ? null : json["is_post_comment"],
    isShare: json["is_share"] == null ? null : json["is_share"],
    isSave: json["is_save"] == null ? null : json["is_save"],
    isNearbyShow: json["is_nearby_show"] == null ? null : json["is_nearby_show"],
    status: json["status"] == null ? null : json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user,
    "type": type == null ? null : type,
    "description": description == null ? null : description,
    "content": content == null ? null : content,
    "color": color == null ? null : color,
    "topic": topic == null ? null : topic,
    "location": location == null ? null : location,
    "tag": tag == null ? null : tag,
    "is_post_view": isPostView == null ? null : isPostView,
    "is_post_comment": isPostComment == null ? null : isPostComment,
    "is_share": isShare == null ? null : isShare,
    "is_save": isSave == null ? null : isSave,
    "is_nearby_show": isNearbyShow == null ? null : isNearbyShow,
    "status": status == null ? null : status,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
