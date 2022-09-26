// To parse this JSON data, do
//
//     final iAddressSchema = iAddressSchemaFromJson(jsonString);

import 'dart:convert';

List<IAddressSchema> iAddressSchemaFromJson(String str) => List<IAddressSchema>.from(json.decode(str).map((x) => IAddressSchema.fromJson(x)));

String iAddressSchemaToJson(List<IAddressSchema> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class IAddressSchema {
  IAddressSchema({
    required this.formattedAddress,
    required this.formattedAddress2,
    required this.streetNumber,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.state,
    required this.stateCode,
    required this.postalCode,
    required this.country,
    required this.countryCode,
    required this.geometry,
    this.apt,
  });

  final String formattedAddress;
  final String? formattedAddress2;
  final String? streetNumber;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String state;
  final String stateCode;
  final String postalCode;
  final String country;
  final String countryCode;
  final Geometry geometry;
  String? apt;

  factory IAddressSchema.fromJson(Map<String, dynamic> json) => IAddressSchema(
        formattedAddress: json["formattedAddress"],
        formattedAddress2: json["formattedAddress2"],
        streetNumber: json["streetNumber"],
        addressLine1: json["addressLine1"],
        addressLine2: json["addressLine2"],
        city: json["city"],
        state: json["state"],
        stateCode: json["stateCode"],
        postalCode: json["postalCode"],
        country: json["country"],
        countryCode: json["countryCode"],
        geometry: Geometry.fromJson(json["geometry"]),
      );

  Map<String, dynamic> toJson() => {
        "formattedAddress": formattedAddress,
        "formattedAddress2": formattedAddress2,
        "streetNumber": streetNumber,
        "addressLine1": addressLine1,
        "addressLine2": addressLine2,
        "city": city,
        "state": state,
        "stateCode": stateCode,
        "postalCode": postalCode,
        "country": country,
        "countryCode": countryCode,
        "geometry": geometry.toJson(),
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  final Location location;
  final Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "viewport": viewport.toJson(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class Viewport {
  Viewport({
    required this.northeast,
    required this.southwest,
  });

  final Location northeast;
  final Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: Location.fromJson(json["northeast"]),
        southwest: Location.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast.toJson(),
        "southwest": southwest.toJson(),
      };
}
