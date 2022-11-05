// To parse this JSON data, do
//
//     final slidePhoneModel = slidePhoneModelFromJson(jsonString);

import 'dart:convert';

List<SlidePhoneModel> slidePhoneModelFromJson(String str) =>
    List<SlidePhoneModel>.from(
        json.decode(str).map((x) => SlidePhoneModel.fromJson(x)));

String slidePhoneModelToJson(List<SlidePhoneModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SlidePhoneModel {
  SlidePhoneModel({
    this.phone,
    this.description,
  });

  String? phone;
  String? description;

  factory SlidePhoneModel.fromJson(Map<String, dynamic> json) =>
      SlidePhoneModel(
        phone: json["phone"] ?? '',
        description: json["description"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "phone": phone,
        "description": description,
      };
}
