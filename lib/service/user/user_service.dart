import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/user/token_model.dart';
import 'package:modi/model/user/user_model.dart';
import 'package:retrofit/http.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @DELETE("/users")
  Future<void> withdraw();

  @POST("/users")
  Future<TokenModel> edit(@Field('nickname') String nickname,
      @Field('introduce') String introduce, @Field('uuid') String imageUuid);

  @GET("/users")
  Future<UserModel> fetchMe();

  @GET("/users/token")
  @Headers({'X-Exclude-Access-Token': 'true'})
  @Headers({'X-Include-Refresh-Token': 'true'})
  Future<TokenModel> fetchRenewToken();
}

class UserService {
  final UserApi _userApi;

  UserService(this._userApi);

  Future<void> withdraw() async {
    try {
      await _userApi.withdraw();
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<TokenModel> edit(String nickname, String introduce, String imageUuid) async {
    try {
      TokenModel tokenModel = await _userApi.edit(nickname, introduce, imageUuid);
      return tokenModel;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<UserModel> fetchMe() async {
    try {
      return await _userApi.fetchMe();
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<TokenModel> fetchRenewToken() async {
    try {
      return await _userApi.fetchRenewToken();
    } on ApiException catch (e) {
      rethrow;
    }
  }
}
