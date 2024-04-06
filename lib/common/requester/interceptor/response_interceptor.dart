import 'package:dio/dio.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/requester/api_response.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:modi/di/injection.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor();

  static LoggingInterface _logger = getIt<LoggingInterface>();

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ApiResponse apiResponse = ApiResponse.fromJson(response.data);

    if (apiResponse.code >= 400) {
      throw ApiException(
          requestOptions: response.requestOptions,
          cause: apiResponse.message,
          code: apiResponse.code);
    }

    response.data = apiResponse.data;

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    bool isApiError = err is ApiException;
    _logger.error('[ERROR] ${isApiError ? err.cause : err}');

    if (!isApiError) {
      super.onError(
          NetworkException(
              requestOptions: err.requestOptions,
              cause: err.message ?? 'Unknown Error'),
          handler);
    }

    super.onError(err, handler);
  }
}
