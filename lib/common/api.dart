import 'package:dio/dio.dart';

import '../info/ip_info.dart';

/// HTTP 요청 객체
final _dio = Dio(
  BaseOptions(
    baseUrl: api,
    connectTimeout: const Duration(seconds: 60),
    receiveTimeout: const Duration(seconds: 60),
    sendTimeout: const Duration(seconds: 60),
  ),
);

/// HTTP 요청 방식
enum _HttpMethod { get, post }

class Api {
  Api._();

  /// 공통 HTTP 요청
  static Future<Response> _request({
    required _HttpMethod method,
    required String url,
    // String? contentType,
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      return await _dio.request(
        url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          method: method.name,
          // contentType: contentType,
          // 헤더 액세스 토큰 필요
        ),
      );
    } on DioException catch (e) {
      // 액세스 토큰 만료 된경우 액세스 토큰 재발급 요청 로직 필요
      return await _request(
        method: method,
        url: url,
        queryParameters: queryParameters,
        data: data,
      );
    }
  }

  /// 내 스터디 API
  static Future<List> getMyStudyList() async {
    final resp = await _dio.get('$api/study/mystudy/5');

    return resp.data['data'];
  }

  /// 회원가입 API
  static Future<void> singUp() async {
    final resp = await _dio.post('$api/users/signup');
    print(resp.data);
  }

  /// 중복확인 API
  static Future<void> checkDuplicateNickname() async {
    final resp = await _dio.get('$api/users/check?nickname={nickname}');

    print(resp.data);
  }
}
