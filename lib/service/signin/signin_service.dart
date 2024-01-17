import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/signin/signin_model.dart';

part 'signin_service.g.dart';

@RestApi()
abstract class SigninApi {
  factory SigninApi(Dio dio, {String baseUrl}) = _SigninApi;

  @POST("/users/login/kakao")
  @Headers({'X-Exclude-Access-Token': 'true'})
  Future<SigninModel> signin(@Header("Authorization") String accessToken);
}

class SigninService {
  final SigninApi _signinApi;
  SigninService(this._signinApi);

  Future<String> signin(String accessToken) async {
    try {
      final response = await _signinApi.signin(accessToken);

      return '';
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
