import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:modi/common/requester/interceptor/auth_interceptor.dart';
import 'package:modi/common/requester/interceptor/custom_log_interceptor.dart';
import 'package:modi/common/requester/interceptor/response_interceptor.dart';

import '../const/environment.dart';
import '../environment/environment.dart';

class RequestBuilder {
  static final BaseOptions _options = BaseOptions(
    baseUrl: Environment.getEnv(API_SERVER),
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),
  );

  static final CacheOptions _cacheOptions = CacheOptions(
    store: MemCacheStore(),
    policy: CachePolicy.request,
    hitCacheOnErrorExcept: [404, 500, 503, 504],
    maxStale: const Duration(days: 7),
    priority: CachePriority.high,
    cipher: null,
    keyBuilder: CacheOptions.defaultCacheKeyBuilder,
    allowPostMethod: true,
  );

  static final Dio _dio = Dio(_options);
  static bool _isInitialize = false;

  static Dio getInstance() {
    if (!_isInitialize) {
      _dio.interceptors.add(DioCacheInterceptor(options: _cacheOptions));
      _dio.interceptors.add(AuthInterceptor());
      _dio.interceptors.add(CustomLogInterceptor());
      _dio.interceptors.add(ResponseInterceptor());
      _isInitialize = true;
    }

    return _dio;
  }
}
