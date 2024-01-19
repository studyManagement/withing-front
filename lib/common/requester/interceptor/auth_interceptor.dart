import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.headers.containsKey('X-Exclude-Access-Token') ||
        options.headers['X-Exclude-Access-Token'] != 'true') {
      final String? token =
          await const FlutterSecureStorage().read(key: 'access_token');

      if (token == null) {
        return super.onRequest(options, handler);
      }

      options.headers.addAll({'authorization': 'Bearer $token'});
    }

    return super.onRequest(options, handler);
  }
}
