// To parse this JSON data, do
//
//     final postModel = postModelFromJson(jsonString);

import 'dart:convert';

PostModel postModelFromJson(String str) => PostModel.fromJson(json.decode(str));

String postModelToJson(PostModel data) => json.encode(data.toJson());

class PostModel {
  PostModel({
    this.message,
    this.responseCode,
    this.status,
    this.data,
  });

  String message;
  String responseCode;
  bool status;
  List<PostData> data;

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
    message: json["message"] == null ? null : json["message"],
    responseCode: json["response_code"] == null ? null : json["response_code"],
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<PostData>.from(json["data"].map((x) => PostData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "message": message == null ? null : message,
    "response_code": responseCode == null ? null : responseCode,
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class PostData {
  PostData({
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
    this.postReaction,
    this.postComment,
  });

  String id;
  List<User> user;
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
  List<PostReaction> postReaction;
  List<dynamic> postComment;

  factory PostData.fromJson(Map<String, dynamic> json) => PostData(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : List<User>.from(json["user"].map((x) => User.fromJson(x))),
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
    postReaction: json["post_reaction"] == null ? null : List<PostReaction>.from(json["post_reaction"].map((x) => PostReaction.fromJson(x))),
    postComment: json["post_comment"] == null ? null : List<dynamic>.from(json["post_comment"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : List<dynamic>.from(user.map((x) => x.toJson())),
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
    "post_reaction": postReaction == null ? null : List<dynamic>.from(postReaction.map((x) => x.toJson())),
    "post_comment": postComment == null ? null : List<dynamic>.from(postComment.map((x) => x)),
  };
}

class PostReaction {
  PostReaction({
    this.id,
    this.user,
    this.post,
    this.reaction,
    this.createdAt,
    this.updatedAt,
  });

  String id;
  String user;
  String post;
  String reaction;
  DateTime createdAt;
  String updatedAt;

  factory PostReaction.fromJson(Map<String, dynamic> json) => PostReaction(
    id: json["id"] == null ? null : json["id"],
    user: json["user"] == null ? null : json["user"],
    post: json["post"] == null ? null : json["post"],
    reaction: json["reaction"] == null ? null : json["reaction"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "user": user == null ? null : user,
    "post": post == null ? null : post,
    "reaction": reaction == null ? null : reaction,
    "created_at": createdAt == null ? null : createdAt.toIso8601String(),
    "updated_at": updatedAt == null ? null : updatedAt,
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
