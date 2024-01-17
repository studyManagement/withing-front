import 'package:dio/dio.dart';

class NetworkException extends DioException {
  String cause;
  NetworkException({required super.requestOptions, required this.cause});
}
