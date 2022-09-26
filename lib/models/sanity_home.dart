// To parse this JSON data, do
//
//     final sanityHome = sanityHomeFromJson(jsonString);

import 'dart:convert';

SanityHome sanityHomeFromJson(String str) => SanityHome.fromJson(json.decode(str));

String sanityHomeToJson(SanityHome data) => json.encode(data.toJson());

class SanityHome {
  SanityHome({
    required this.ms,
    required this.query,
    required this.result,
  });

  int ms;
  String query;
  List<Result> result;

  factory SanityHome.fromJson(Map<String, dynamic> json) => SanityHome(
        ms: json["ms"],
        query: json["query"],
        result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ms": ms,
        "query": query,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    required this.createdAt,
    required this.id,
    required this.rev,
    required this.type,
    required this.updatedAt,
    required this.contents,
    required this.screenName,
    required this.slug,
  });

  DateTime createdAt;
  String id;
  String rev;
  String type;
  DateTime updatedAt;
  List<Content> contents;
  ScreenName screenName;
  Slug slug;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        createdAt: DateTime.parse(json["_createdAt"]),
        id: json["_id"],
        rev: json["_rev"],
        type: json["_type"],
        updatedAt: DateTime.parse(json["_updatedAt"]),
        contents: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
        screenName: ScreenName.fromJson(json["screenName"]),
        slug: Slug.fromJson(json["slug"]),
      );

  Map<String, dynamic> toJson() => {
        "_createdAt": createdAt.toIso8601String(),
        "_id": id,
        "_rev": rev,
        "_type": type,
        "_updatedAt": updatedAt.toIso8601String(),
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
        "screenName": screenName.toJson(),
        "slug": slug.toJson(),
      };
}

class Content {
  Content({
    required this.key,
    required this.type,
    required this.contentKey,
    required this.text,
    required this.image,
  });

  String key;
  ContentType type;
  Key contentKey;
  ScreenName text;
  ContentImage image;

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        key: json["_key"],
        type: contentTypeValues.map[json["_type"]]!,
        contentKey: Key.fromJson(json["key"]),
        text: ScreenName.fromJson(json["text"]),
        image: ContentImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "_key": key,
        "_type": contentTypeValues.reverse[type],
        "key": contentKey.toJson(),
        "text": text.toJson(),
        "image": image.toJson(),
      };
}

class Key {
  Key({
    required this.type,
    required this.contentKey,
  });

  KeyType type;
  String contentKey;

  factory Key.fromJson(Map<String, dynamic> json) => Key(
        type: keyTypeValues.map[json["_type"]]!,
        contentKey: json["contentKey"],
      );

  Map<String, dynamic> toJson() => {
        "_type": keyTypeValues.reverse[type],
        "contentKey": contentKey,
      };
}

enum KeyType { CONTENT_KEY }

final keyTypeValues = EnumValues({"contentKey": KeyType.CONTENT_KEY});

class ContentImage {
  ContentImage({
    required this.type,
    required this.alt,
    required this.image,
  });

  String type;
  Alt alt;
  ImageImage image;

  factory ContentImage.fromJson(Map<String, dynamic> json) => ContentImage(
        type: json["_type"],
        alt: Alt.fromJson(json["alt"]),
        image: ImageImage.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "_type": type,
        "alt": alt.toJson(),
        "image": image.toJson(),
      };
}

class Alt {
  Alt({
    required this.type,
    required this.en,
  });

  AltType type;
  String en;

  factory Alt.fromJson(Map<String, dynamic> json) => Alt(
        type: altTypeValues.map[json["_type"]]!,
        en: json["en"],
      );

  Map<String, dynamic> toJson() => {
        "_type": altTypeValues.reverse[type],
        "en": en,
      };
}

enum AltType { LOCALE_STRING }

final altTypeValues = EnumValues({"localeString": AltType.LOCALE_STRING});

class ImageImage {
  ImageImage({
    required this.type,
    required this.en,
  });

  String type;
  En en;

  factory ImageImage.fromJson(Map<String, dynamic> json) => ImageImage(
        type: json["_type"],
        en: En.fromJson(json["en"]),
      );

  Map<String, dynamic> toJson() => {
        "_type": type,
        "en": en.toJson(),
      };
}

class En {
  En({
    required this.type,
    required this.asset,
  });

  String type;
  Asset asset;

  factory En.fromJson(Map<String, dynamic> json) => En(
        type: json["_type"],
        asset: Asset.fromJson(json["asset"]),
      );

  Map<String, dynamic> toJson() => {
        "_type": type,
        "asset": asset.toJson(),
      };
}

class Asset {
  Asset({
    required this.ref,
    required this.type,
  });

  String ref;
  String type;

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
        ref: json["_ref"],
        type: json["_type"],
      );

  Map<String, dynamic> toJson() => {
        "_ref": ref,
        "_type": type,
      };
}

class ScreenName {
  ScreenName({
    required this.type,
    required this.en,
    required this.fr,
  });

  AltType type;
  String en;
  String fr;

  factory ScreenName.fromJson(Map<String, dynamic> json) => ScreenName(
        type: altTypeValues.map[json["_type"]]!,
        en: json["en"],
        fr: json["fr"],
      );

  Map<String, dynamic> toJson() => {
        "_type": altTypeValues.reverse[type],
        "en": en,
        "fr": fr,
      };
}

enum ContentType { TEXT_DATA, IMAGE_FILE }

final contentTypeValues = EnumValues({"imageFile": ContentType.IMAGE_FILE, "textData": ContentType.TEXT_DATA});

class Slug {
  Slug({
    required this.type,
    required this.current,
  });

  String type;
  String current;

  factory Slug.fromJson(Map<String, dynamic> json) => Slug(
        type: json["_type"],
        current: json["current"],
      );

  Map<String, dynamic> toJson() => {
        "_type": type,
        "current": current,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(
    this.map,
  );

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
