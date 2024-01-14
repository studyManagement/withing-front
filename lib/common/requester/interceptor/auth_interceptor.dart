import 'package:dio/dio.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {}

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {}

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {}
}
