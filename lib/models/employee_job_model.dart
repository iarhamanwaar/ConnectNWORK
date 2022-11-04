// To parse this JSON data, do
//
//     final employeeJob = employeeJobFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<EmployeeJob> employeeJobFromJson(String str) => List<EmployeeJob>.from(json.decode(str).map((x) => EmployeeJob.fromJson(x)));

String employeeJobToJson(List<EmployeeJob> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeJob {
  EmployeeJob({
    this.id,
    this.job,
    this.status,
    this.cancelReason,
  });

  String? id;
  Job? job;
  String? status;
  dynamic cancelReason;

  factory EmployeeJob.fromJson(Map<String, dynamic> json) => EmployeeJob(
        id: json["_id"] == null ? null : json["_id"],
        job: json["job"] == null ? null : Job.fromJson(json["job"]),
        status: json["status"] == null ? null : json["status"],
        cancelReason: json["cancelReason"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "job": job == null ? null : job!.toJson(),
        "status": status == null ? null : status,
        "cancelReason": cancelReason,
      };
}

class Job {
  Job({
    this.id,
    this.employer,
    this.category,
    this.sanityCategoryId,
    this.title,
    this.sanityTitleId,
    this.location,
    this.description,
    this.shift,
  });

  String? id;
  Employer? employer;
  String? category;
  String? sanityCategoryId;
  String? title;
  String? sanityTitleId;
  JobLocation? location;
  String? description;
  Shift? shift;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"] == null ? null : json["_id"],
        employer: json["employer"] == null ? null : Employer.fromJson(json["employer"]),
        category: json["category"] == null ? null : json["category"],
        sanityCategoryId: json["sanityCategoryId"] == null ? null : json["sanityCategoryId"],
        title: json["title"] == null ? null : json["title"],
        sanityTitleId: json["sanityTitleId"] == null ? null : json["sanityTitleId"],
        location: json["location"] == null ? null : JobLocation.fromJson(json["location"]),
        description: json["description"] == null ? null : json["description"],
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "employer": employer == null ? null : employer!.toJson(),
        "category": category == null ? null : category,
        "sanityCategoryId": sanityCategoryId == null ? null : sanityCategoryId,
        "title": title == null ? null : title,
        "sanityTitleId": sanityTitleId == null ? null : sanityTitleId,
        "location": location == null ? null : location!.toJson(),
        "description": description == null ? null : description,
        "shift": shift == null ? null : shift!.toJson(),
      };
}

class Employer {
  Employer({
    this.id,
    this.name,
    this.logo,
  });

  String? id;
  String? name;
  String? logo;

  factory Employer.fromJson(Map<String, dynamic> json) => Employer(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
        logo: json["logo"] == null ? null : json["logo"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
        "logo": logo == null ? null : logo,
      };
}

class JobLocation {
  JobLocation({
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

  factory JobLocation.fromJson(Map<String, dynamic> json) => JobLocation(
        geoLocation: json["geoLocation"] == null ? null : GeoLocation.fromJson(json["geoLocation"]),
        apt: json["apt"],
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
    this.type,
    this.coordinates,
  });

  String? type;
  List<double>? coordinates;

  factory GeoLocation.fromJson(Map<String, dynamic> json) => GeoLocation(
        type: json["type"] == null ? null : json["type"],
        coordinates: json["coordinates"] == null ? null : List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type == null ? null : type,
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
      };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  NortheastClass? location;
  Viewport? viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: json["location"] == null ? null : NortheastClass.fromJson(json["location"]),
        viewport: json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location == null ? null : location!.toJson(),
        "viewport": viewport == null ? null : viewport!.toJson(),
      };
}

class NortheastClass {
  NortheastClass({
    this.lat,
    this.lng,
  });

  double? lat;
  double? lng;

  factory NortheastClass.fromJson(Map<String, dynamic> json) => NortheastClass(
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
    this.northeast,
    this.southwest,
  });

  NortheastClass? northeast;
  NortheastClass? southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
        northeast: json["northeast"] == null ? null : NortheastClass.fromJson(json["northeast"]),
        southwest: json["southwest"] == null ? null : NortheastClass.fromJson(json["southwest"]),
      );

  Map<String, dynamic> toJson() => {
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}

class Shift {
  Shift({
    this.numberOfWorkers,
    this.ratePerHr,
    this.currency,
    this.startTime,
    this.endTime,
    this.days,
    this.paidHrs,
    this.tip,
    this.id,
  });

  int? numberOfWorkers;
  double? ratePerHr;
  String? currency;
  DateTime? startTime;
  DateTime? endTime;
  List<DateTime>? days;
  double? paidHrs;
  bool? tip;
  String? id;

  factory Shift.fromJson(Map<String, dynamic> json) => Shift(
        numberOfWorkers: json["numberOfWorkers"] == null ? null : json["numberOfWorkers"],
        ratePerHr: json["ratePerHr"] == null ? null : json["ratePerHr"]!.toDouble(),
        currency: json["currency"] == null ? null : json["currency"],
        startTime: json["startTime"] == null ? null : DateTime.parse(json["startTime"]),
        endTime: json["endTime"] == null ? null : DateTime.parse(json["endTime"]),
        days: json["days"] == null ? null : List<DateTime>.from(json["days"].map((x) => DateTime.parse(x))),
        paidHrs: json["paidHrs"] == null ? null : json["paidHrs"]!.toDouble(),
        tip: json["tip"] == null ? null : json["tip"],
        id: json["id"] == null ? null : json["id"],
      );

  Map<String, dynamic> toJson() => {
        "numberOfWorkers": numberOfWorkers == null ? null : numberOfWorkers,
        "ratePerHr": ratePerHr == null ? null : ratePerHr,
        "currency": currency == null ? null : currency,
        "startTime": startTime == null ? null : startTime!.toIso8601String(),
        "endTime": endTime == null ? null : endTime!.toIso8601String(),
        "days": days == null ? null : List<dynamic>.from(days!.map((x) => x.toIso8601String())),
        "paidHrs": paidHrs == null ? null : paidHrs,
        "tip": tip == null ? null : tip,
        "id": id == null ? null : id,
      };
}
