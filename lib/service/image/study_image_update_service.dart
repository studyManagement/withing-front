import 'dart:io';

import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';

part 'study_image_update_service.g.dart';

/// API
@RestApi()
abstract class StudyImageUpdateApi {
  factory StudyImageUpdateApi(Dio dio, {String baseUrl}) = _StudyImageUpdateApi;

  @PATCH("/studies/{study_id}/images")
  @MultiPart()
  @Headers({'Content-Type': 'multipart/form-data'})
  Future<int> update(
    @Path("study_id") String studyId,
    @Part(name: "study_image") File? image,
  );
}

/// Service
class StudyImageUpdateService {
  final StudyImageUpdateApi _api;

  StudyImageUpdateService(this._api);

  Future<int> callCreateApi(
    String studyId,
    File? image,
  ) async {
    try {
      debugPrint('[API]');
      final response = await _api.update(
        studyId,
        image,
      );
      print(response);
      return response;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }
}
