// To parse this JSON data, do
//
//     final signUpResponse = signUpResponseFromJson(jsonString);

import 'dart:convert';

SignUpResponse signUpResponseFromJson(String str) => SignUpResponse.fromJson(json.decode(str));

String signUpResponseToJson(SignUpResponse data) => json.encode(data.toJson());

class SignUpResponse {
  String email;
  String password;
  String name;
  String role;
  String avatar;
  int id;
  DateTime creationAt;
  DateTime updatedAt;

  SignUpResponse({
    required this.email,
    required this.password,
    required this.name,
    required this.role,
    required this.avatar,
    required this.id,
    required this.creationAt,
    required this.updatedAt,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
    email: json["email"],
    password: json["password"],
    name: json["name"],
    role: json["role"],
    avatar: json["avatar"],
    id: json["id"],
    creationAt: DateTime.parse(json["creationAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
    "name": name,
    "role": role,
    "avatar": avatar,
    "id": id,
    "creationAt": creationAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
