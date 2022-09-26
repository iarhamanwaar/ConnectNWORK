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

  final User? user;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
      };
}

class User {
  User({
    required this.suspended,
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
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  final bool? suspended;
  final String? id;
  final String? fuid;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final bool? idVerified;
  final Address? address;
  final String? locale;
  final String? picture;
  final List<String>? type;
  final dynamic resume;
  final dynamic workPermit;
  final String? phoneNumber;
  final String? interac;
  final dynamic bio;
  final dynamic dob;
  final bool? notification;
  final dynamic ssn;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  factory User.fromJson(Map<String, dynamic> json) => User(
        suspended: json["suspended"],
        id: json["_id"],
        fuid: json["fuid"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        fullName: json["fullName"],
        email: json["email"],
        idVerified: json["idVerified"],
        address: Address.fromJson(json["address"]),
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
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "suspended": suspended,
        "_id": id,
        "fuid": fuid,
        "firstName": firstName,
        "lastName": lastName,
        "fullName": fullName,
        "email": email,
        "idVerified": idVerified,
        "address": address!.toJson(),
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}

class Address {
  Address({
    required this.geoLocation,
    required this.apt,
    required this.streetNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.postalCode,
    required this.state,
    required this.stateCode,
    required this.country,
    required this.countryCode,
    required this.formattedAddress,
    required this.formattedAddress2,
  });

  final GeoLocation? geoLocation;
  final dynamic apt;
  final String? streetNumber;
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final String? postalCode;
  final String? state;
  final String? stateCode;
  final String? country;
  final String? countryCode;
  final String? formattedAddress;
  final String? formattedAddress2;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geoLocation: GeoLocation.fromJson(json["geoLocation"]),
        apt: json["apt"],
        streetNumber: json["streetNumber"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        postalCode: json["postalCode"],
        state: json["state"],
        stateCode: json["stateCode"],
        country: json["country"],
        countryCode: json["countryCode"],
        formattedAddress: json["formattedAddress"],
        formattedAddress2: json["formattedAddress2"],
      );

  Map<String, dynamic> toJson() => {
        "geoLocation": geoLocation!.toJson(),
        "apt": apt,
        "streetNumber": streetNumber,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "postalCode": postalCode,
        "state": state,
        "stateCode": stateCode,
        "country": country,
        "countryCode": countryCode,
        "formattedAddress": formattedAddress,
        "formattedAddress2": formattedAddress2,
      };
}

class GeoLocation {
  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<int>? coordinates;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        type: json["type"],
        coordinates: List<int>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}
