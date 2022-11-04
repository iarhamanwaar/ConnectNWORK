// To parse this JSON data, do
//
//     final earnings = earningsFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

List<Earnings> earningsFromJson(String str) => List<Earnings>.from(json.decode(str).map((x) => Earnings.fromJson(x)));

String earningsToJson(List<Earnings> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Earnings {
  Earnings({
    this.id,
    this.user,
    this.period,
    this.hours,
    this.total,
    this.deductionTotal,
    this.earning,
    this.approved,
    this.deductions,
    this.createdAt,
    this.updatedAt,
    this.paidOn,
    this.jobs,
    this.employer,
  });

  String? id;
  String? user;
  Period? period;
  double? hours;
  double? total;
  double? deductionTotal;
  double? earning;
  bool? approved;
  Deductions? deductions;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? paidOn;
  List<JobElement>? jobs;
  String? employer;

  factory Earnings.fromJson(Map<String, dynamic> json) => Earnings(
        id: json["_id"] == null ? null : json["_id"],
        user: json["user"] == null ? null : json["user"],
        period: json["period"] == null ? null : Period.fromJson(json["period"]),
        hours: json["hours"] == null ? null : json["hours"]!.toDouble(),
        total: json["total"] == null ? null : json["total"]!.toDouble(),
        deductionTotal: json["deductionTotal"] == null ? null : json["deductionTotal"]!.toDouble(),
        earning: json["earning"] == null ? null : json["earning"]!.toDouble(),
        approved: json["approved"] == null ? null : json["approved"],
        deductions: json["deductions"] == null ? null : Deductions.fromJson(json["deductions"]),
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
        paidOn: json["paidOn"] == null ? null : DateTime.parse(json["paidOn"]),
        jobs: json["jobs"] == null ? null : List<JobElement>.from(json["jobs"].map((x) => JobElement.fromJson(x))),
        employer: json["employer"] == null ? null : json["employer"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "user": user == null ? null : user,
        "period": period == null ? null : period!.toJson(),
        "hours": hours == null ? null : hours,
        "total": total == null ? null : total,
        "deductionTotal": deductionTotal == null ? null : deductionTotal,
        "earning": earning == null ? null : earning,
        "approved": approved == null ? null : approved,
        "deductions": deductions == null ? null : deductions!.toJson(),
        "createdAt": createdAt == null ? null : createdAt!.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt!.toIso8601String(),
        "paidOn": paidOn == null ? null : paidOn!.toIso8601String(),
        "jobs": jobs == null ? null : List<dynamic>.from(jobs!.map((x) => x.toJson())),
        "employer": employer == null ? null : employer,
      };
}

class Deductions {
  Deductions({
    this.annuity,
    this.fedTax,
    this.insurance,
    this.qcTax,
    this.rqap,
  });

  double? annuity;
  double? fedTax;
  int? insurance;
  double? qcTax;
  double? rqap;

  factory Deductions.fromJson(Map<String, dynamic> json) => Deductions(
        annuity: json["annuity"] == null ? null : json["annuity"]!.toDouble(),
        fedTax: json["fedTax"] == null ? null : json["fedTax"]!.toDouble(),
        insurance: json["insurance"] == null ? null : json["insurance"],
        qcTax: json["qcTax"] == null ? null : json["qcTax"]!.toDouble(),
        rqap: json["rqap"] == null ? null : json["rqap"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "annuity": annuity == null ? null : annuity,
        "fedTax": fedTax == null ? null : fedTax,
        "insurance": insurance == null ? null : insurance,
        "qcTax": qcTax == null ? null : qcTax,
        "rqap": rqap == null ? null : rqap,
      };
}

class JobElement {
  JobElement({
    this.job,
    this.totalEarned,
  });

  JobJob? job;
  double? totalEarned;

  factory JobElement.fromJson(Map<String, dynamic> json) => JobElement(
        job: json["job"] == null ? null : JobJob.fromJson(json["job"]),
        totalEarned: json["totalEarned"] == null ? null : json["totalEarned"]!.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "job": job == null ? null : job!.toJson(),
        "totalEarned": totalEarned == null ? null : totalEarned,
      };
}

class JobJob {
  JobJob({
    this.id,
    this.employer,
    this.title,
    this.shift,
  });

  String? id;
  Employer? employer;
  String? title;
  Shift? shift;

  factory JobJob.fromJson(Map<String, dynamic> json) => JobJob(
        id: json["_id"] == null ? null : json["_id"],
        employer: json["employer"] == null ? null : Employer.fromJson(json["employer"]),
        title: json["title"] == null ? null : json["title"],
        shift: json["shift"] == null ? null : Shift.fromJson(json["shift"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "employer": employer == null ? null : employer!.toJson(),
        "title": title == null ? null : title,
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

class Period {
  Period({
    this.start,
    this.end,
  });

  DateTime? start;
  DateTime? end;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "start": start == null ? null : start!.toIso8601String(),
        "end": end == null ? null : end!.toIso8601String(),
      };
}
