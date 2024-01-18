import 'package:dio/dio.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/api_response.dart';
import 'package:withing/common/requester/network_exception.dart';

class ResponseInterceptor extends Interceptor {
  ResponseInterceptor();

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
    if (err is! ApiException) {
      super.onError(
          NetworkException(
              requestOptions: err.requestOptions,
              cause: err.message ?? 'Unknown Error'),
          handler);
    }

    super.onError(err, handler);
  }
}
