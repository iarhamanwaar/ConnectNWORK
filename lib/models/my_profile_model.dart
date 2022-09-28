// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);

import 'dart:convert';

MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));

String myProfileToJson(MyProfile data) => json.encode(data.toJson());

class MyProfile {
  MyProfile({
    required this.user,
  });

  User? user;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };
}

class User {
  User({
    required this.id,
    required this.fuid,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.idVerified,
    required this.address,
    required this.locale,
    required this.picture,
    required this.type,
    required this.resume,
    required this.workPermit,
    required this.phoneNumber,
    required this.interac,
    required this.bio,
    required this.dob,
    required this.notification,
    required this.ssn,
    required this.suspended,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  String? id;
  String? fuid;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  bool? idVerified;
  dynamic address;
  String? locale;
  String? picture;
  List<String>? type;
  dynamic resume;
  dynamic workPermit;
  dynamic phoneNumber;
  dynamic interac;
  dynamic bio;
  dynamic dob;
  bool? notification;
  dynamic ssn;
  bool? suspended;
  DateTime? createdAt;
  DateTime? updatedAt;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        fuid: json["fuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        idVerified: json["idVerified"],
        address: json["address"],
        locale: json["locale"],
        picture: json["picture"],
        type: List<String>.from(json["type"].map((x) => x)),
        resume: json["resume"],
        workPermit: json["workPermit"],
        phoneNumber: json["phoneNumber"],
        interac: json["interac"],
        bio: json["bio"],
        dob: json["dob"],
        notification: json["notification"],
        ssn: json["ssn"],
        suspended: json["suspended"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "fuid": fuid,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "email": email,
        "idVerified": idVerified,
        "address": address,
        "locale": locale,
        "picture": picture,
        "type": List<dynamic>.from(type!.map((x) => x)),
        "resume": resume,
        "workPermit": workPermit,
        "phoneNumber": phoneNumber,
        "interac": interac,
        "bio": bio,
        "dob": dob,
        "notification": notification,
        "ssn": ssn,
        "suspended": suspended,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
