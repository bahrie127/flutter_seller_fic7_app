import 'dart:convert';

class AddProductResponseModel {
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final int categoryId;
  final int userId;
  final DateTime updatedAt;
  final DateTime createdAt;
  final int id;

  AddProductResponseModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.userId,
    required this.updatedAt,
    required this.createdAt,
    required this.id,
  });

  factory AddProductResponseModel.fromJson(String str) =>
      AddProductResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddProductResponseModel.fromMap(Map<String, dynamic> json) =>
      AddProductResponseModel(
        name: json["name"],
        description: json["description"],
        price: json["price"],
        imageUrl: json["image_url"],
        categoryId: json["category_id"],
        userId: json["user_id"],
        updatedAt: DateTime.parse(json["updated_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "description": description,
        "price": price,
        "image_url": imageUrl,
        "category_id": categoryId,
        "user_id": userId,
        "updated_at": updatedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "id": id,
      };
}
