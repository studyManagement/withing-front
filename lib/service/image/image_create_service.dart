import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';
part 'image_create_service.g.dart';

/// API
@RestApi()
abstract class ImageCreateApi {
  factory ImageCreateApi(Dio dio, {String baseUrl}) = _ImageCreateApi;

  @POST("/images")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<int> create(
    @Part(name: "image") File image,
  );
}

/// Service
class ImageCreateService {
  final ImageCreateApi _api;

  ImageCreateService(this._api);

  Future<int> callImageCreateApi(
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
