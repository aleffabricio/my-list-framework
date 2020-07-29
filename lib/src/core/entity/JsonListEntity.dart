import 'dart:convert';

import 'package:my_list_framework/src/core/entity/albums_entity.dart';
import 'package:my_list_framework/src/core/entity/posts_entity.dart';
import 'package:my_list_framework/src/core/entity/todos_entity.dart';

JsonListEntity jsonListEntityFromJson(String str) => JsonListEntity.fromJson(json.decode(str));

String jsonListEntityToJson(JsonListEntity data) => json.encode(data.toJson());

class JsonListEntity {
  JsonListEntity({
    this.albums,
    this.posts,
    this.todos,
  });

  List<AlbumsEntity> albums;
  List<PostsEntity> posts;
  List<TodosEntity> todos;

  factory JsonListEntity.fromJson(Map<String, dynamic> json) => JsonListEntity(
    albums: List<AlbumsEntity>.from(json["albums"].map((x) => AlbumsEntity.fromJson(x))),
    posts: List<PostsEntity>.from(json["posts"].map((x) => PostsEntity.fromJson(x))),
    todos: List<TodosEntity>.from(json["todos"].map((x) => TodosEntity.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "albums": List<dynamic>.from(albums.map((x) => x.toJson())),
    "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
    "todos": List<dynamic>.from(todos.map((x) => x.toJson())),
  };
}