// To parse this JSON data, do
//
//     final notification = notificationFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<Notification> notificationFromJson(String str) => List<Notification>.from(json.decode(str).map((x) => Notification.fromJson(x)));

String notificationToJson(List<Notification> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Notification {
  Notification({
    this.id,
    this.user,
    this.body,
    this.title,
    this.type,
    this.tag,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  String? id;
  String? user;
  String? body;
  String? title;
  String? type;
  String? tag;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        body: json["body"] == null ? null : json["body"],
        title: json["title"] == null ? null : json["title"],
        type: json["type"] == null ? null : json["type"],
        tag: json["tag"] == null ? null : json["tag"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "body": body == null ? null : body,
        "title": title == null ? null : title,
        "type": type == null ? null : type,
        "tag": tag == null ? null : tag,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
      };
}
