import 'dart:convert';

class ApiResponse {
  int code;
  String message;
  dynamic data;
  bool success;

  ApiResponse(this.code, this.message, this.data, this.success);

  factory ApiResponse.fromJson(dynamic json) {
    Map<String, dynamic> jsonMap = {};

    if (json is Map<String, dynamic>) {
      jsonMap['code'] = json['code'];
      jsonMap['message'] = json['message'];
      jsonMap['data'] = json['data'];
      jsonMap['success'] = json['success'];
    } else {
      jsonMap = jsonDecode(json);
    }

    return ApiResponse(jsonMap['code'] as int, jsonMap['message'] as String,
        jsonMap['data'] as dynamic ?? List.empty(), jsonMap['success'] as bool);
  }
}
