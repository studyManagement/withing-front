import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/network_exception.dart';
import 'package:withing/model/signup/signup_model.dart';

part 'signup_service.g.dart';

@RestApi()
abstract class SignupApi {
  factory SignupApi(Dio dio, {String baseUrl}) = _SignupApi;

  @POST("/users/signup")
  @Headers({'X-Exclude-Access-Token': 'true'})
  Future<SignupModel> signup(
    @Field("social_id_type") String provider,
    @Field("nickname") String nickname,
    @Field("social_id") String accessToken,
    @Field("introduce") String introduce,
  );

  @GET("/users/check")
  @Headers({'X-Exclude-Access-Token': 'true'})
  Future<String> isDuplicate(@Query("nickname") String nickname);
}

class SignupService {
  final SignupApi _signupApi;
  SignupService(this._signupApi);

  Future<SignupModel> signup(String provider, String nickname,
      String socialUUID, String introduce) async {
    try {
      final response =
          await _signupApi.signup(provider, nickname, socialUUID, introduce);

      return response;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<bool> isDuplicate(String nickname) async {
    try {
      await _signupApi.isDuplicate(nickname);
      return false;
    } on ApiException catch (e) {
      return true;
    }
  }
}
