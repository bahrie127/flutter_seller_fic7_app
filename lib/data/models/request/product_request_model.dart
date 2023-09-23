import 'dart:convert';

// {

//             "name": "Mie gacoan 33",
//             "description": "Molestias magnam qui rerum laborum.",
//             "price": 30000,
//             "image_url": "https://via.placeholder.com/200x200.png/0088ee?text=deserunt",
//             "category_id": 2

//         }

class ProductRequestModel {
  final String name;
  final String description;
  final int price;
  final String imageUrl;
  final int categoryId;
  ProductRequestModel({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
  });

  ProductRequestModel copyWith({
    String? name,
    String? description,
    int? price,
    String? imageUrl,
    int? categoryId,
  }) {
    return ProductRequestModel(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      categoryId: categoryId ?? this.categoryId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'category_id': categoryId,
    };
  }

  factory ProductRequestModel.fromMap(Map<String, dynamic> map) {
    return ProductRequestModel(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: map['price']?.toInt() ?? 0,
      imageUrl: map['imageUrl'] ?? '',
      categoryId: map['categoryId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductRequestModel.fromJson(String source) =>
      ProductRequestModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ProductRequestModel(name: $name, description: $description, price: $price, imageUrl: $imageUrl, categoryId: $categoryId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductRequestModel &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.imageUrl == imageUrl &&
        other.categoryId == categoryId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        imageUrl.hashCode ^
        categoryId.hashCode;
  }
}
