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
    this.emailSubscription,
    this.certnVerify,
    this.rating,
    this.id,
    this.fuid,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.idVerified,
    this.address,
    this.locale,
    this.picture,
    this.type,
    this.resume,
    this.workPermit,
    this.phoneNumber,
    this.interac,
    this.bio,
    this.dob,
    this.notification,
    this.ssn,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.deviceIds,
    this.status,
    this.timezone,
  });

  bool? emailSubscription;
  bool? certnVerify;
  dynamic rating;
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
  String? ssn;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  List<String>? deviceIds;
  String? status;
  String? timezone;

  factory MyProfile.fromJson(Map<String, dynamic> json) => MyProfile(
        emailSubscription: json["emailSubscription"] == null ? null : json["emailSubscription"],
        certnVerify: json["certnVerify"] == null ? null : json["certnVerify"],
        rating: json["rating"],
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
        ssn: json["ssn"] == null ? null : json["ssn"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        v: json["__v"] == null ? null : json["__v"],
        deviceIds: json["deviceIds"] == null ? null : List<String>.from(json["deviceIds"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        timezone: json["timezone"] == null ? null : json["timezone"],
      );

  Map<String, dynamic> toJson() => {
        "emailSubscription": emailSubscription == null ? null : emailSubscription,
        "certnVerify": certnVerify == null ? null : certnVerify,
        "rating": rating,
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
        "ssn": ssn == null ? null : ssn,
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "__v": v == null ? null : v,
        "deviceIds": deviceIds == null ? null : List<dynamic>.from(deviceIds!.map((x) => x)),
        "status": status == null ? null : status,
        "timezone": timezone == null ? null : timezone,
      };
}

class Address {
  Address({
    this.geoLocation,
    this.apt,
    this.streetNumber,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.postalCode,
    this.state,
    this.stateCode,
    this.country,
    this.countryCode,
    this.formattedAddress,
    this.formattedAddress2,
    this.geometry,
  });

  GeoLocation? geoLocation;
  String? apt;
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
  dynamic geometry;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        geoLocation: json["geoLocation"] == null ? null : GeoLocation.fromJson(json["geoLocation"]),
        apt: json["apt"] == null ? null : json["apt"],
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
        geometry: json["geometry"],
      );

  IAddressSchema toIAddressSchema() {
    return IAddressSchema(
      formattedAddress: country == null ? '' : formattedAddress!,
      formattedAddress2: formattedAddress2,
      streetNumber: streetNumber,
      addressLine1: country == null ? '' : addressLine1!,
      addressLine2: addressLine2,
      city: country == null ? '' : city!,
      state: country == null ? '' : state!,
      stateCode: country == null ? '' : stateCode!,
      postalCode: country == null ? '' : postalCode!,
      country: country == null ? '' : country!,
      countryCode: country == null ? '' : countryCode!,
      geometry: null,
      apt: apt,
    );
  }

  Map<String, dynamic> toJson() => {
        "geoLocation": geoLocation == null ? null : geoLocation!.toJson(),
        "apt": apt == null ? null : apt,
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
        "geometry": geometry == null ? null : geometry,
      };
}

class GeoLocation {
  GeoLocation({
    this.type,
    this.coordinates,
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
