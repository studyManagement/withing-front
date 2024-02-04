import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/const/environment.dart';
import 'package:modi/common/environment/environment.dart';
import 'package:modi/common/requester/request_builder.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('X-Exclude-Access-Token') ||
        options.headers['X-Exclude-Access-Token'] != 'true') {
      final String? token = Authentication.instance.accessToken;

      if (token == null) {
        return super.onRequest(options, handler);
      }

      options.headers.addAll({'authorization': token});
    }

    return super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? refreshToken = Authentication.instance.refreshToken;

      if (refreshToken == null) {
        return Authentication.instance
            .logout(reason: '로그인 세션이 만료되었습니다.\n로그인을 다시 시도해 주세요.');
      }

      try {
        final response = await Dio().get(
          '${Environment.getEnv(API_SERVER)}/users/token',
          options: Options(
            headers: {
              'authorization': refreshToken,
            },
          ),
        );

        log('[RENEW] ${response.data}');

        String renewAccessToken = response.data['data']['accessToken'];
        String renewRefreshToken = response.data['data']['refreshToken'];

        Authentication.from(renewAccessToken, renewRefreshToken);
      } on DioException catch (e) {
        return Authentication.instance
            .logout(reason: '로그인 세션이 만료되었습니다.\n로그인을 다시 시도해 주세요.');
      }

      final retryResponse = await RequestBuilder.getInstance().request(
        err.response!.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: Options(
          method: err.requestOptions.method,
          headers: err.requestOptions.headers,
        ),
      );

      return handler.resolve(retryResponse);
    }

    return super.onError(err, handler);
  }
}
