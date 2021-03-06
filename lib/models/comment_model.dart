// To parse this JSON data, do
//
//     final commentModel = commentModelFromJson(jsonString);

import 'dart:convert';

CommentModel commentModelFromJson(String str) =>
    CommentModel.fromJson(json.decode(str));

String commentModelToJson(CommentModel data) => json.encode(data.toJson());

class CommentModel {
  CommentModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  List<CommentData> data;

  factory CommentModel.fromJson(Map<String, dynamic> json) => CommentModel(
        message: json["message"] == null ? null : json["message"],
        responseCode:
            json["response_code"] == null ? null : json["response_code"],
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null
            ? null
            : List<CommentData>.from(
                json["data"].map((x) => CommentData.fromJson(x))),
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

class CommentData {
  CommentData({
    this.id,
    this.parent,
    this.user,
    this.post,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String parent;
  List<User> user;
  List<Post> post;
  String content;
  DateTime createdAt;
  String updatedAt;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        id: json["id"] == null ? null : json["id"],
        parent: json["parent"] == null ? null : json["parent"],
        user: json["user"] == null
            ? null
            : List<User>.from(json["user"].map((x) => User.fromJson(x))),
        post: json["post"] == null
            ? null
            : List<Post>.from(json["post"].map((x) => Post.fromJson(x))),
        content: json["content"] == null ? null : json["content"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "parent": parent == null ? null : parent,
        "user": user == null
            ? null
            : List<dynamic>.from(user.map((x) => x.toJson())),
        "post": post == null
            ? null
            : List<dynamic>.from(post.map((x) => x.toJson())),
        "content": content == null ? null : content,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}

class Post {
  Post({
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
  DateTime updatedAt;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
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
        isPostComment:
            json["is_post_comment"] == null ? null : json["is_post_comment"],
        isShare: json["is_share"] == null ? null : json["is_share"],
        isSave: json["is_save"] == null ? null : json["is_save"],
        isNearbyShow:
            json["is_nearby_show"] == null ? null : json["is_nearby_show"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}

class User {
  User({
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
  DateTime date;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
        "date": date == null ? null : date.toIso8601String(),
      };
}
