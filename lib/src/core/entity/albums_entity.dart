import 'dart:convert';

List<AlbumsEntity> albumsEntityFromJson(String str) => List<AlbumsEntity>.from(
    json.decode(str).map((x) => AlbumsEntity.fromJson(x)));

String albumsEntityToJson(List<AlbumsEntity> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AlbumsEntity {
  AlbumsEntity(
    this.userId,
    this.id,
    this.title,
  );

  int userId;
  int id;
  String title;

  factory AlbumsEntity.fromJson(Map<String, dynamic> json) => AlbumsEntity(
        json["userId"],
        json["id"],
        json["title"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
      };
}
