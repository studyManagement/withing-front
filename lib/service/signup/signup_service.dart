import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/signup/signup_model.dart';

part 'signup_service.g.dart';

@RestApi()
abstract class SignupApi {
  factory SignupApi(Dio dio, {String baseUrl}) = _SignupApi;

  @POST("/users/signup")
  Future<SignupModel> signup(
    @Field("provider") String provider,
    @Field("nickname") String nickname,
    @Field("access_token") String accessToken,
    @Field("introduce") String introduce,
  );

  @GET("/users/check")
  Future<String> isDuplicate(@Query("nickname") String nickname);
}

class SignupService {
  final SignupApi _signupApi;
  SignupService(this._signupApi);

  Future<SignupModel> signup(String provider, String nickname,
      String accessToken, String introduce) async {
    try {
      final response =
          await _signupApi.signup(provider, nickname, accessToken, introduce);

      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<bool> isDuplicate(String nickname) async {
    try {
      await _signupApi.isDuplicate(nickname);
      return true;
    } on ApiException catch (e) {
      return false;
    }
  }
}
