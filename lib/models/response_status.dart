// To parse this JSON data, do
//
//     final responseStatus = responseStatusFromJson(jsonString);

import 'dart:convert';

ResponseStatus responseStatusFromJson(String str) =>
    ResponseStatus.fromJson(json.decode(str));

String responseStatusToJson(ResponseStatus data) => json.encode(data.toJson());

class ResponseStatus {
  ResponseStatus({
    required this.error,
    required this.message,
  });

  String error;
  String message;

  factory ResponseStatus.fromJson(Map<String, dynamic> json) => ResponseStatus(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
