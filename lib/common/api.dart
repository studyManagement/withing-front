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
      return await _request(
        method: method,
        url: url,
        queryParameters: queryParameters,
        data: data,
      );
    }
  }

  /// 회원가입 API
  static Future<Response?> singUp({
    required int userId,
    required String nickname,
    String? introduce,
    String? userImage,
  }) async {
    return await _request(
      method: _HttpMethod.post,
      url: '$api/users/signup',
      data: {
        'user_id': userId,
        'nickname': nickname,
        'introduce': introduce,
        'user_image': userImage,
      },
    );
  }

  /// 닉네임 중복확인 API
  static Future<Response?> checkDuplicateNickname({
    required String nickname,
  }) async {
    return await _request(
      method: _HttpMethod.get,
      queryParameters: {
        'nickname': nickname,
      },
      url: '$api/users/check',
    );
  }

  /// 회원가입 여부 API
  static Future<Response?> getUserInfo({
    required int userId,
  }) async {
    return await _request(
      method: _HttpMethod.get,
      url: '$api/users/$userId',
    );
  }

  /// 내 스터디 API
  static Future<List> getMyStudyList({
    required int users,
    required String mystudy,
  }) async {
    // final resp = await _dio.get('$api/study/mystudy/5');
    final resp = await _request(method: _HttpMethod.get, url: '$api/study/mystudy/5', queryParameters: {
      'users': users,
      'mystudy': mystudy,
    });

    return resp.data['data'];
  }
}
