import 'dart:convert';

import 'package:my_list_framework/src/core/entity/albums_entity.dart';

List<TodosEntity> todosEntityFromJson(String str) => List<TodosEntity>.from(
    json.decode(str).map((x) => TodosEntity.fromJson(x)));

String todosEntityToJson(List<TodosEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TodosEntity extends AlbumsEntity {
  TodosEntity({this.completed, userId, id, title}) : super(userId, id, title);

  bool completed;

  factory TodosEntity.fromJson(Map<String, dynamic> json) => TodosEntity(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };
}
