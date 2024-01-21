import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/authenticator/authentication.dart';
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

      Authentication.from(token.accessToken, token.refreshToken);
      Authentication.instance.save();

      return;
    } on ApiException catch (e) {
      if (e.code == 404) {
        throw UserNotFoundException();
      }

      rethrow;
    }
  }
}
