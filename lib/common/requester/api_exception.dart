import 'package:dio/dio.dart';

class ApiException extends DioException {
  String cause;
  int code;

  ApiException(
      {required super.requestOptions, required this.cause, required this.code});
}
