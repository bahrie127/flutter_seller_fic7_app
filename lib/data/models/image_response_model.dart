import 'dart:convert';

// {
//     "image_path": "/upload/images/1695392700.png",
//     "base_url": "http://localhost:8000"
// }

class ImageResponseModel {
  final String imagePath;
  final String baseUrl;
  ImageResponseModel({
    required this.imagePath,
    required this.baseUrl,
  });

  ImageResponseModel copyWith({
    String? imagePath,
    String? baseUrl,
  }) {
    return ImageResponseModel(
      imagePath: imagePath ?? this.imagePath,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'imagePath': imagePath,
      'baseUrl': baseUrl,
    };
  }

  factory ImageResponseModel.fromMap(Map<String, dynamic> map) {
    return ImageResponseModel(
      imagePath: map['image_path'] ?? '',
      baseUrl: map['base_url'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ImageResponseModel.fromJson(String source) => ImageResponseModel.fromMap(json.decode(source));

  @override
  String toString() => 'ImageResponseModel(imagePath: $imagePath, baseUrl: $baseUrl)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is ImageResponseModel &&
      other.imagePath == imagePath &&
      other.baseUrl == baseUrl;
  }

  @override
  int get hashCode => imagePath.hashCode ^ baseUrl.hashCode;
}
