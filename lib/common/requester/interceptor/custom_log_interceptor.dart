import 'package:dio/dio.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/di/injection.dart';

class CustomLogInterceptor extends Interceptor {
  CustomLogInterceptor();

  static LoggingInterface _logger = getIt<LoggingInterface>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logger.info(
        '[REQUEST] ${options.method} ${options.path} ${options.queryParameters} ${options.headers} ${options.data}');
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logger.error('[ERROR] $err');
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.info(
        '[RESPONSE] ${response.requestOptions.path} ${response.requestOptions.queryParameters} ${response.headers} - ${response.headers} ${response.data}');
    super.onResponse(response, handler);
  }
}
