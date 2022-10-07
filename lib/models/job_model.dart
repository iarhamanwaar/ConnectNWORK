// To parse this JSON data, do
//
//     final job = jobFromJson(jsonString);

import 'dart:convert';

List<Job> jobFromJson(String str) => List<Job>.from(json.decode(str).map((x) => Job.fromJson(x)));

String jobToJson(List<Job> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Job {
  Job({
    required this.id,
    required this.employer,
    required this.category,
    required this.sanityCategoryId,
    required this.title,
    required this.sanityTitleId,
    required this.location,
    required this.description,
    required this.v,
    required this.shift,
  });

  final String? id;
  final Employer? employer;
  final String? category;
  final String? sanityCategoryId;
  final String? title;
  final String? sanityTitleId;
  final JobLocation? location;
  final String? description;
  final int? v;
  final Shift? shift;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        employer: Employer.fromJson(json["employer"]),
        category: json["category"],
        sanityCategoryId: json["sanityCategoryId"],
        title: json["title"],
        sanityTitleId: json["sanityTitleId"],
        location: JobLocation.fromJson(json["location"]),
        description: json["description"],
        v: json["__v"],
        shift: Shift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employer": employer!.toJson(),
        "category": category,
        "sanityCategoryId": sanityCategoryId,
        "title": title,
        "sanityTitleId": sanityTitleId,
        "location": location!.toJson(),
        "description": description,
        "__v": v,
        "shift": shift!.toJson(),
      };
}

class Employer {
  Employer({
    required this.id,
    required this.name,
    required this.logo,
  });

  final String? id;
  final String? name;
  final String? logo;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["_id"],
        name: json["name"],
        logo: json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "logo": logo,
      };
}

class JobLocation {
  JobLocation({
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
  final Geometry? geometry;

  factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
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
        geometry: Geometry.fromJson(json["geometry"]),
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
        "geometry": geometry!.toJson(),
      };
}

class GeoLocation {
  GeoLocation({
    required this.type,
    required this.coordinates,
  });

  final String? type;
  final List<double>? coordinates;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    required this.location,
    required this.viewport,
  });

  final NortheastClass? location;
  final Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: NortheastClass.fromJson(json["location"]),
        viewport: Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location!.toJson(),
        "viewport": viewport!.toJson(),
      };
}

class NortheastClass {
  NortheastClass({
    required this.lat,
    required this.lng,
  });

  final double? lat;
  final double? lng;

  factory NortheastClass.fromJson(Map<String, dynamic> json) => NortheastClass(
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

  final NortheastClass? northeast;
  final NortheastClass? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: NortheastClass.fromJson(json["northeast"]),
        southwest: NortheastClass.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast!.toJson(),
        "southwest": southwest!.toJson(),
      };
}

class Shift {
  Shift({
    required this.numberOfWorkers,
    required this.ratePerHr,
    required this.currency,
    required this.startTime,
    required this.endTime,
    required this.days,
    required this.paidHrs,
    required this.tip,
  });

  final int? numberOfWorkers;
  final double? ratePerHr;
  final String? currency;
  final DateTime? startTime;
  final DateTime? endTime;
  final List<DateTime>? days;
  final double? paidHrs;
  final bool? tip;

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        numberOfWorkers: json["numberOfWorkers"],
        ratePerHr: json["ratePerHr"].toDouble(),
        currency: json["currency"],
        startTime: DateTime.parse(json["startTime"]),
        endTime: DateTime.parse(json["endTime"]),
        days: List<DateTime>.from(json["days"].map((x) => DateTime.parse(x))),
        paidHrs: json["paidHrs"].toDouble(),
        tip: json["tip"],
      );

  Map<String, dynamic> toJson() => {
        "numberOfWorkers": numberOfWorkers,
        "ratePerHr": ratePerHr,
        "currency": currency,
        "startTime": startTime!.toIso8601String(),
        "endTime": endTime!.toIso8601String(),
        "days": List<dynamic>.from(days!.map((x) => x.toIso8601String())),
        "paidHrs": paidHrs,
        "tip": tip,
      };
}
