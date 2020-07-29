import 'dart:convert';

import 'package:my_list_framework/src/core/entity/albums_entity.dart';

List<PostsEntity> postsEntityFromJson(String str) => List<PostsEntity>.from(
    json.decode(str).map((x) => PostsEntity.fromJson(x)));

String postsEntityToJson(List<PostsEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostsEntity extends AlbumsEntity {
  PostsEntity({this.body, userId, id, title}) : super(userId, id, title);

  String body;

  factory PostsEntity.fromJson(Map<String, dynamic> json) => PostsEntity(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
