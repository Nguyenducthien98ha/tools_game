// To parse this JSON data, do
//
//     final getGamesModel = getGamesModelFromJson(jsonString);

import 'dart:convert';

List<GetGamesModel> getGamesModelFromJson(String str) =>
    List<GetGamesModel>.from(
        json.decode(str).map((x) => GetGamesModel.fromJson(x)));

String getGamesModelToJson(List<GetGamesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetGamesModel {
  GetGamesModel({
    this.id,
    this.featureImageName,
    this.featureImagePath,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? featureImageName;
  String? featureImagePath;
  String? name;
  String? createdAt;
  String? updatedAt;

  factory GetGamesModel.fromJson(Map<String, dynamic> json) => GetGamesModel(
        id: json["id"],
        featureImageName: json["feature_image_name"],
        featureImagePath: json["feature_image_path"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "feature_image_name": featureImageName,
        "feature_image_path": featureImagePath,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
