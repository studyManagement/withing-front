import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';
part 'study_image_create_service.g.dart';

/// API
@RestApi()
abstract class StudyImageCreateApi {
  factory StudyImageCreateApi(Dio dio, {String baseUrl}) = _StudyImageCreateApi;

  @POST("/studies/images")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<int> create(
    @Part(name: "study_image") File image,
  );
}

/// Service
class StudyImageCreateService {
  final StudyImageCreateApi _api;

  StudyImageCreateService(this._api);

  Future<int> callCreateApi(
    File image,
  ) async {
    try {
      final response = await _api.create(
        image,
      );
      return response;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
