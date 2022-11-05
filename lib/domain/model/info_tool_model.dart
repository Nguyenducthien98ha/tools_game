// To parse this JSON data, do
//
//     final infoToolModel = infoToolModelFromJson(jsonString);

import 'dart:convert';

InfoToolModel infoToolModelFromJson(String str) =>
    InfoToolModel.fromJson(json.decode(str));

String infoToolModelToJson(InfoToolModel data) => json.encode(data.toJson());

class InfoToolModel {
  InfoToolModel({
    this.id,
    this.status,
    this.hotline,
    this.linkLoginSuccess,
    this.createdAt,
    this.updatedAt,
    this.textOnTop,
  });

  int? id;
  int? status;
  String? hotline;
  String? linkLoginSuccess;
  String? createdAt;
  String? updatedAt;
  String? textOnTop;

  factory InfoToolModel.fromJson(Map<String, dynamic> json) => InfoToolModel(
        id: json["id"] ?? '',
        status: json["status"] ?? '',
        hotline: json["hotline"] ?? '',
        linkLoginSuccess: json["link_login_success"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
        textOnTop: json["text_on_top"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "hotline": hotline,
        "link_login_success": linkLoginSuccess,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "text_on_top": textOnTop,
      };
}
