import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/user/user_model.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @DELETE("/users")
  Future<void> withdraw();

  @POST("/users")
  Future<void> edit(
      @Field('nickname') String nickname, @Field('introduce') String introduce);

  @GET("/me")
  Future<UserModel> fetchMe();
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

  Future<void> edit(String nickname, String introduce) async {
    try {
      await _userApi.edit(nickname, introduce);
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
}
