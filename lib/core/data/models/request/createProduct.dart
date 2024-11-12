// To parse this JSON data, do
//
//     final createProductRequest = createProductRequestFromJson(jsonString);

import 'dart:convert';

CreateProductRequest createProductRequestFromJson(String str) => CreateProductRequest.fromJson(json.decode(str));

String createProductRequestToJson(CreateProductRequest data) => json.encode(data.toJson());

class CreateProductRequest {
  String? title;
  dynamic price;
  String? description;
  int? categoryId;
  List<String>? images;

  CreateProductRequest({
     this.title,
     this.price,
     this.description,
     this.categoryId,
     this.images,
  });

  factory CreateProductRequest.fromJson(Map<String, dynamic> json) => CreateProductRequest(
    title: json["title"],
    price: json["price"],
    description: json["description"],
    categoryId: json["categoryId"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "price": price,
    "description": description,
    "categoryId": categoryId,
    "images": images!=null?List<dynamic>.from(images!.map((x) => x)):[],
  };
}
