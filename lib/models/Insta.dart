// To parse this JSON data, do
//
//     final insta = instaFromJson(jsonString);

import 'dart:convert';

HashtagSearchResponse instaFromJson(String str) {
  final jsonData = json.decode(str);
  return HashtagSearchResponse.fromJson(jsonData);
}

String instaToJson(HashtagSearchResponse data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class HashtagSearchResponse {
  List<HashtagElement> hashtags;

  HashtagSearchResponse({
    this.hashtags,
  });

  factory HashtagSearchResponse.fromJson(Map<String, dynamic> json) =>
      new HashtagSearchResponse(
        hashtags: new List<HashtagElement>.from(
            json["hashtags"].map((x) => HashtagElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "hashtags": new List<dynamic>.from(hashtags.map((x) => x.toJson())),
      };
}

class HashtagElement {
  int position;
  HashtagHashtag hashtag;

  HashtagElement({
    this.position,
    this.hashtag,
  });

  factory HashtagElement.fromJson(Map<String, dynamic> json) =>
      new HashtagElement(
        position: json["position"],
        hashtag: HashtagHashtag.fromJson(json["hashtag"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "hashtag": hashtag.toJson(),
      };
}

class HashtagHashtag {
  String name;
  double id;
  int mediaCount;
  String searchResultSubtitle;

  HashtagHashtag({
    this.name,
    this.id,
    this.mediaCount,
    this.searchResultSubtitle,
  });

  factory HashtagHashtag.fromJson(Map<String, dynamic> json) =>
      new HashtagHashtag(
        name: "#" + json["name"],
        id: json["id"].toDouble(),
        mediaCount: json["media_count"],
        searchResultSubtitle: json["search_result_subtitle"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "media_count": mediaCount,
        "search_result_subtitle": searchResultSubtitle,
      };
}
