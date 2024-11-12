// To parse this JSON data, do
//
//     final signUpRequest = signUpRequestFromJson(jsonString);

import 'dart:convert';

SignUpRequest signUpRequestFromJson(String str) => SignUpRequest.fromJson(json.decode(str));

String signUpRequestToJson(SignUpRequest data) => json.encode(data.toJson());

class SignUpRequest {
  String name;
  String email;
  String password;
  String avatar;

  SignUpRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.avatar,
  });

  factory SignUpRequest.fromJson(Map<String, dynamic> json) => SignUpRequest(
    name: json["name"],
    email: json["email"],
    password: json["password"],
    avatar: json["avatar"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "avatar": avatar,
  };
}
