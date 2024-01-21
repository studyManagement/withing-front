import 'package:dio/dio.dart';
import 'package:withing/common/authenticator/authentication.dart';

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
}
