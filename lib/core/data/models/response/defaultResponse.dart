// To parse this JSON data, do
//
//     final defaultErrorFormat = defaultErrorFormatFromJson(jsonString);

import 'dart:convert';

DefaultErrorFormat defaultErrorFormatFromJson(String str) => DefaultErrorFormat.fromJson(json.decode(str));

String defaultErrorFormatToJson(DefaultErrorFormat data) => json.encode(data.toJson());

class DefaultErrorFormat {
  List<String> message;
  String error;
  int statusCode;

  DefaultErrorFormat({
    required this.message,
    required this.error,
    required this.statusCode,
  });

  factory DefaultErrorFormat.fromJson(Map<String, dynamic> json) => DefaultErrorFormat(
    message: List<String>.from(json["message"].map((x) => x)),
    error: json["error"],
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "message": List<dynamic>.from(message.map((x) => x)),
    "error": error,
    "statusCode": statusCode,
  };
}
