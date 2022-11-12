// To parse this JSON data, do
//
//     final myProfile = myProfileFromJson(jsonString);
// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

import 'package:connectnwork/models/iaddress_schema.dart';

MyProfile myProfileFromJson(String str) => MyProfile.fromJson(json.decode(str));

String myProfileToJson(MyProfile data) => json.encode(data.toJson());

class MyProfile {
  MyProfile({
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
    required this.deviceIds,
  });

  bool? suspended;
  String? id;
  String? fuid;
  String? firstName;
  String? lastName;
  String? fullName;
  String? email;
  bool? idVerified;
  Address? address;
  String? locale;
  String? picture;
  List<String>? type;
  dynamic resume;
  dynamic workPermit;
  String? phoneNumber;
  String? interac;
  dynamic bio;
  DateTime? dob;
  bool? notification;
  dynamic ssn;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? deviceIds;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        suspended: json["suspended"] == null ? null : json["suspended"],
        id: json["_id"] == null ? null : json["_id"],
        fuid: json["fuid"] == null ? null : json["fuid"],
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        fullName: json["fullName"] == null ? null : json["fullName"],
        email: json["email"] == null ? null : json["email"],
        idVerified: json["idVerified"] == null ? null : json["idVerified"],
        address: json["address"] == null ? null : Address.fromJson(json["address"]),
        locale: json["locale"] == null ? null : json["locale"],
        picture: json["picture"] == null ? null : json["picture"],
        type: json["type"] == null ? null : List<String>.from(json["type"].map((x) => x)),
        resume: json["resume"],
        workPermit: json["workPermit"],
        phoneNumber: json["phoneNumber"] == null ? null : json["phoneNumber"],
        interac: json["interac"] == null ? null : json["interac"],
        bio: json["bio"],
        dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
        notification: json["notification"] == null ? null : json["notification"],
        ssn: json["ssn"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        deviceIds: json["deviceIds"] == null ? null : List<String>.from(json["deviceIds"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "suspended": suspended == null ? null : suspended,
        "_id": id == null ? null : id,
        "fuid": fuid == null ? null : fuid,
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "fullName": fullName == null ? null : fullName,
        "email": email == null ? null : email,
        "idVerified": idVerified == null ? null : idVerified,
        "address": address == null ? null : address!.toJson(),
        "locale": locale == null ? null : locale,
        "picture": picture == null ? null : picture,
        "type": type == null ? null : List<dynamic>.from(type!.map((x) => x)),
        "resume": resume,
        "workPermit": workPermit,
        "phoneNumber": phoneNumber == null ? null : phoneNumber,
        "interac": interac == null ? null : interac,
        "bio": bio,
        "dob": dob == null ? null : dob!.toIso8601String(),
        "notification": notification == null ? null : notification,
        "ssn": ssn,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
        "deviceIds": deviceIds == null ? null : List<dynamic>.from(deviceIds!.map((x) => x)),
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
    required this.geometry,
  });

  GeoLocation? geoLocation;
  dynamic apt;
  String? streetNumber;
  String? addressLine1;
  String? addressLine2;
  String? city;
  String? postalCode;
  String? state;
  String? stateCode;
  String? country;
  String? countryCode;
  String? formattedAddress;
  String? formattedAddress2;
  Geometry? geometry;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geoLocation: json["geoLocation"] == null ? null : GeoLocation.fromJson(json["geoLocation"]),
        apt: json["apt"] == null ? null : json['apt'],
        streetNumber: json["streetNumber"] == null ? null : json["streetNumber"],
        addressLine1: json["addressLine1"] == null ? null : json["addressLine1"],
        addressLine2: json["addressLine2"] == null ? null : json["addressLine2"],
        city: json["city"] == null ? null : json["city"],
        postalCode: json["postalCode"] == null ? null : json["postalCode"],
        state: json["state"] == null ? null : json["state"],
        stateCode: json["stateCode"] == null ? null : json["stateCode"],
        country: json["country"] == null ? null : json["country"],
        countryCode: json["countryCode"] == null ? null : json["countryCode"],
        formattedAddress: json["formattedAddress"] == null ? null : json["formattedAddress"],
        formattedAddress2: json["formattedAddress2"] == null ? null : json["formattedAddress2"],
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
      );

  IAddressSchema toIAddressSchema() {
    return IAddressSchema(
      formattedAddress: formattedAddress!,
      formattedAddress2: formattedAddress2,
      streetNumber: streetNumber,
      addressLine1: addressLine1!,
      addressLine2: addressLine2,
      city: city!,
      state: state!,
      stateCode: stateCode!,
      postalCode: postalCode!,
      country: country!,
      countryCode: countryCode!,
      geometry: null,
      apt: apt,
    );
  }

  Map<String, dynamic> toJson() => {
        "geoLocation": geoLocation == null ? null : geoLocation!.toJson(),
        "apt": apt,
        "streetNumber": streetNumber == null ? null : streetNumber,
        "addressLine1": addressLine1 == null ? null : addressLine1,
        "addressLine2": addressLine2 == null ? null : addressLine2,
        "city": city == null ? null : city,
        "postalCode": postalCode == null ? null : postalCode,
        "state": state == null ? null : state,
        "stateCode": stateCode == null ? null : stateCode,
        "country": country == null ? null : country,
        "countryCode": countryCode == null ? null : countryCode,
        "formattedAddress": formattedAddress == null ? null : formattedAddress,
        "formattedAddress2": formattedAddress2 == null ? null : formattedAddress2,
        "geometry": geometry == null ? null : geometry!.toJson(),
      };
}

class GeoLocation {
  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  String? type;
  List<int>? coordinates;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null ? null : List<int>.from(json["coordinates"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  Location? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null ? null : Location.fromJson(json["location"]),
        viewport: json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double? lat;
  double? lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"] == null ? null : json["lat"]!.toDouble(),
        lng: json["lng"] == null ? null : json["lng"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat == null ? null : lat,
        "lng": lng == null ? null : lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  Location? northeast;
  Location? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null ? null : Location.fromJson(json["northeast"]),
        southwest: json["southwest"] == null ? null : Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}
