import 'package:dio/dio.dart' hide Headers;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/exception/signin/user_not_found_exception.dart';
import 'package:withing/model/signin/signin_model.dart';

part 'signin_service.g.dart';

@RestApi()
abstract class SigninApi {
  factory SigninApi(Dio dio, {String baseUrl}) = _SigninApi;

  @POST("/login/kakao")
  @Headers({'X-Exclude-Access-Token': 'true'})
  Future<SigninModel> signin(@Header("Authorization") String accessToken);
}

class SigninService {
  final SigninApi _signinApi;
  SigninService(this._signinApi);

  Future<void> signin(String accessToken) async {
    try {
      final SigninModel token = await _signinApi.signin(accessToken);
      await const FlutterSecureStorage()
          .write(key: 'access_token', value: token.accessToken);
      await const FlutterSecureStorage()
          .write(key: 'refresh_token', value: token.refreshToken);

      return;
    } on ApiException catch (e) {
      if (e.code == 404) {
        throw UserNotFoundException();
      }

      rethrow;
    }
  }
}
