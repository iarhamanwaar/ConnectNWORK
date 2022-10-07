// To parse this JSON data, do
//
//     final employeeJob = employeeJobFromJson(jsonString);

import 'dart:convert';

List<EmployeeJob> employeeJobFromJson(String str) => List<EmployeeJob>.from(json.decode(str).map((x) => EmployeeJob.fromJson(x)));

String employeeJobToJson(List<EmployeeJob> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class EmployeeJob {
  EmployeeJob({
    required this.id,
    required this.job,
    required this.status,
    required this.cancelReason,
    required this.earnings,
  });

  final String? id;
  final Job? job;
  final String? status;
  final dynamic cancelReason;
  final List<Earning>? earnings;

  factory EmployeeJob.fromJson(Map<String, dynamic> json) => EmployeeJob(
        id: json["_id"],
        job: Job.fromJson(json["job"]),
        status: json["status"],
        cancelReason: json["cancelReason"],
        earnings: List<Earning>.from(json["earnings"].map((x) => Earning.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "job": job == null ? null : job!.toJson(),
        "status": status,
        "cancelReason": cancelReason,
        "earnings": List<dynamic>.from(earnings!.map((x) => x.toJson())),
      };
}

class Earning {
  Earning({
    required this.deductions,
    required this.period,
    required this.hours,
    required this.total,
    required this.deductionTotal,
    required this.earning,
  });

  final Deductions? deductions;
  final Period? period;
  final int? hours;
  final int? total;
  final double? deductionTotal;
  final double? earning;

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
        deductions: Deductions.fromJson(json["deductions"]),
        period: Period.fromJson(json["period"]),
        hours: json["hours"],
        total: json["total"],
        deductionTotal: json["deductionTotal"].toDouble(),
        earning: json["earning"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "deductions": deductions == null ? null : deductions!.toJson(),
        "period": period == null ? null : period!.toJson(),
        "hours": hours,
        "total": total,
        "deductionTotal": deductionTotal,
        "earning": earning,
      };
}

class Deductions {
  Deductions({
    required this.annuity,
    required this.fedTax,
    required this.insurance,
    required this.qcTax,
    required this.rqap,
  });

  final double? annuity;
  final double? fedTax;
  final int? insurance;
  final double? qcTax;
  final double? rqap;

  factory Deductions.fromJson(Map<String, dynamic> json) => Deductions(
        annuity: json["annuity"].toDouble(),
        fedTax: json["fedTax"].toDouble(),
        insurance: json["insurance"],
        qcTax: json["qcTax"].toDouble(),
        rqap: json["rqap"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "annuity": annuity,
        "fedTax": fedTax,
        "insurance": insurance,
        "qcTax": qcTax,
        "rqap": rqap,
      };
}

class Period {
  Period({
    required this.start,
    required this.end,
  });

  final DateTime? start;
  final DateTime? end;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        start: DateTime.parse(json["start"]),
        end: DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "start": start == null ? null : start!.toIso8601String(),
        "end": end == null ? null : end!.toIso8601String(),
      };
}

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
  });

  final String? id;
  final Employer? employer;
  final String? category;
  final String? sanityCategoryId;
  final String? title;
  final String? sanityTitleId;
  final JobLocation? location;
  final String? description;

  factory Job.fromJson(Map<String, dynamic> json) => Job(
        id: json["_id"],
        employer: Employer.fromJson(json["employer"]),
        category: json["category"],
        sanityCategoryId: json["sanityCategoryId"],
        title: json["title"],
        sanityTitleId: json["sanityTitleId"],
        location: JobLocation.fromJson(json["location"]),
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "employer": employer == null ? null : employer!.toJson(),
        "category": category,
        "sanityCategoryId": sanityCategoryId,
        "title": title,
        "sanityTitleId": sanityTitleId,
        "location": location == null ? null : location!.toJson(),
        "description": description,
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
        "geoLocation": geoLocation == null ? null : geoLocation!.toJson(),
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
        "geometry": geometry == null ? null : geometry!.toJson(),
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
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates!.map((x) => x)),
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
        "location": location == null ? null : location!.toJson(),
        "viewport": viewport == null ? null : viewport!.toJson(),
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
        "northeast": northeast == null ? null : northeast!.toJson(),
        "southwest": southwest == null ? null : southwest!.toJson(),
      };
}
