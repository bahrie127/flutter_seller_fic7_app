import 'package:meta/meta.dart';
import 'dart:convert';

class CategoriesResponseModel {
  final List<Category> data;

  CategoriesResponseModel({
    required this.data,
  });

  factory CategoriesResponseModel.fromJson(String str) =>
      CategoriesResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoriesResponseModel.fromMap(Map<String, dynamic> json) =>
      CategoriesResponseModel(
        data: List<Category>.from(json["data"].map((x) => Category.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Category {
  final int id;
  final String name;
  final String description;
  final DateTime createdAt;
  final DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(String str) => Category.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Category.fromMap(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "description": description,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
