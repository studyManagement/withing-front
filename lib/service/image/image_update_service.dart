import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';

part 'image_update_service.g.dart';

/// API
@RestApi()
abstract class ImageUpdateApi {
  factory ImageUpdateApi(Dio dio, {String baseUrl}) = _ImageUpdateApi;

  @PATCH("/studies/{study_id}/images") // 추후 수정 필요
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<int> update(
    @Path("study_id") int studyId,
    @Part(name: "study_image") File image,
  );
}

/// Service
class ImageUpdateService {
  final ImageUpdateApi _api;

  ImageUpdateService(this._api);

  Future<int> callImageUpdateApi(
    int studyId,
    File image,
  ) async {
    try {
      final response = await _api.update(
        studyId,
        image,
      );
      return response;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
