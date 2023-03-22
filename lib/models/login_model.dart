// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  LoginModel({
    required this.error,
    required this.message,
    required this.role,
  });

  String error;
  String message;
  String role;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        error: json["error"],
        message: json["message"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "role": role,
      };
}
