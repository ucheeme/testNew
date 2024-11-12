// To parse this JSON data, do
//
//     final createProductResponse = createProductResponseFromJson(jsonString);

import 'dart:convert';

CreateProductResponse createProductResponseFromJson(String str) => CreateProductResponse.fromJson(json.decode(str));

String createProductResponseToJson(CreateProductResponse data) => json.encode(data.toJson());

class CreateProductResponse {
  String title;
  int price;
  String description;
  List<String> images;
  Category category;
  int id;
  DateTime creationAt;
  DateTime updatedAt;

  CreateProductResponse({
    required this.title,
    required this.price,
    required this.description,
    required this.images,
    required this.category,
    required this.id,
    required this.creationAt,
    required this.updatedAt,
  });

  factory CreateProductResponse.fromJson(Map<String, dynamic> json) => CreateProductResponse(
    title: json["title"],
    price: json["price"],
    description: json["description"],
    images: List<String>.from(json["images"].map((x) => x)),
    category: Category.fromJson(json["category"]),
    id: json["id"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "description": description,
    "images": List<dynamic>.from(images.map((x) => x)),
    "category": category.toJson(),
    "id": id,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Category {
  int id;
  String name;
  String image;
  DateTime creationAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.image,
    required this.creationAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
