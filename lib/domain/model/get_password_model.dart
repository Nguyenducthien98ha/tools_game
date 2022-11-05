// To parse this JSON data, do
//
//     final getPasswordModel = getPasswordModelFromJson(jsonString);

import 'dart:convert';

GetPasswordModel getPasswordModelFromJson(String str) =>
    GetPasswordModel.fromJson(json.decode(str));

String getPasswordModelToJson(GetPasswordModel data) =>
    json.encode(data.toJson());

class GetPasswordModel {
  GetPasswordModel({
    this.id,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? password;
  String? createdAt;
  String? updatedAt;

  factory GetPasswordModel.fromJson(Map<String, dynamic> json) =>
      GetPasswordModel(
        id: json["id"] ?? '',
        password: json["password"] ?? '',
        createdAt: json["created_at"] ?? '',
        updatedAt: json["updated_at"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "password": password,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
