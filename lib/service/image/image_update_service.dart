import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';

part 'image_update_service.g.dart';

/// API
@RestApi()
abstract class ImageUpdateApi {
  factory ImageUpdateApi(Dio dio, {String baseUrl}) = _ImageUpdateApi;

  @PATCH("/images")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<String> update(
    @Part(name: "image") File image,
  );
}

/// Service
class ImageUpdateService {
  final ImageUpdateApi _api;

  ImageUpdateService(this._api);

  Future<String> callImageUpdateApi(
    File image,
  ) async {
    try {
      final response = await _api.update(
        image,
      );
      return response;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
