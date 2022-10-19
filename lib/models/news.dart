// ignore_for_file: prefer_if_null_operators, prefer_null_aware_operators
import 'dart:convert';

List<NewsModel> newsModelFromJson(String str) => List<NewsModel>.from(json.decode(str).map((x) => NewsModel.fromJson(x)));

String newsModelToJson(List<NewsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NewsModel {
  NewsModel({
    required this.id,
    required this.topic,
    required this.detail,
    required this.imageurl,
    required this.linkurl,
    required this.createdAt,
    required this.status,
  });

  String id;
  String topic;
  String detail;
  String imageurl;
  String linkurl;
  DateTime? createdAt;
  String status;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        id: json["id"] == null ? null : json["id"],
        topic: json["topic"] == null ? null : json["topic"],
        detail: json["detail"] == null ? null : json["detail"],
        imageurl: json["imageurl"] == null ? null : json["imageurl"],
        linkurl: json["linkurl"] == null ? null : json["linkurl"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        status: json["status"] == null ? null : json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "topic": topic == null ? null : topic,
        "detail": detail == null ? null : detail,
        "imageurl": imageurl == null ? null : imageurl,
        "linkurl": linkurl == null ? null : linkurl,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "status": status == null ? null : status,
      };
}
