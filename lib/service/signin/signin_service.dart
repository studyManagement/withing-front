import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/signin/user_not_found_exception.dart';
import 'package:modi/model/signin/signin_model.dart';
import 'package:retrofit/http.dart';

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
