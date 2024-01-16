import 'package:dio/dio.dart';
import 'package:withing/common/requester/interceptor/response_interceptor.dart';

import '../const/environment.dart';
import '../environment/environment.dart';
import 'interceptor/auth_interceptor.dart';

class RequestBuilder {
  static final BaseOptions _options = BaseOptions(
    baseUrl: Environment.getEnv(API_SERVER),
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  );

  static final Dio _dio = Dio(_options);
  static bool _isInitialize = false;

  static Dio getInstance() {
    if (!_isInitialize) {
      _dio.interceptors.add(LogInterceptor());
      _dio.interceptors.add(AuthInterceptor());
      _dio.interceptors.add(ResponseInterceptor());
      _isInitialize = true;
    }

    return _dio;
  }
}
