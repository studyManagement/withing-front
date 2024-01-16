import 'dart:developer';

import 'package:dio/dio.dart';

class CustomLogInterceptor extends Interceptor {
  CustomLogInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log('[REQUEST] ${options.path} ${options.queryParameters} ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('[ERROR] ${err.response?.requestOptions.path} ${err.response?.requestOptions.queryParameters} ${err.response?.requestOptions.data} - ${err.response?.statusCode} - ${err.response?.data}');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[RESPONSE] ${response.requestOptions.path} ${response.requestOptions.queryParameters} ${response.headers} - ${response.data}');
    super.onResponse(response, handler);
  }
}
