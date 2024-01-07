import 'dart:convert';

class ApiResponse {
  int code;
  String message;
  dynamic data;
  bool success;

  ApiResponse(this.code, this.message, this.data, this.success);

  factory ApiResponse.fromJson(String json) {
    Map<String, dynamic> jsonMap = jsonDecode(json);

    return ApiResponse(jsonMap['code'] as int, jsonMap['message'] as String,
        jsonMap['data'] as dynamic, jsonMap['success'] as bool);
  }

  @override
  String toString() {
    return 'ApiResponse(code=$code,message=$message,data=$data,success=$success)';
  }
}
