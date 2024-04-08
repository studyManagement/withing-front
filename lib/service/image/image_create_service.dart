import 'dart:io';
import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/image/image_exception.dart';
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
  Future<String> create(
    @Part(name: "image") File image,
  );
}

/// Service
class ImageCreateService {
  final ImageCreateApi _api;

  ImageCreateService(this._api);

  Future<String> callImageCreateApi(
    File image,
  ) async {
    try {
      final response = await _api.create(
        image,
      );
      return response;
    } on ApiException catch (e){
      throw ImageException(e.cause, e.code);
    }
  }
}
