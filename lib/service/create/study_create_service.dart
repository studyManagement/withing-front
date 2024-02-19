import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';

import '../../common/requester/network_exception.dart';
import '../../model/create/created_study_info_model.dart';
import '../../model/create/new_study_info_model.dart';
import '../../model/study/study_model.dart';

part 'study_create_service.g.dart';

/// API
@RestApi()
abstract class StudyCreateApi {
  factory StudyCreateApi(Dio dio, {String baseUrl}) = _StudyCreateApi;

  @POST("/studies")
//  @Headers({'Content-Type': 'multipart/form-data'})
  Future<StudyModel> create(
    @Body() Map<String, dynamic> data,
  );
}

/// Service
class StudyCreateService {
  final StudyCreateApi _api;

  StudyCreateService(this._api);

  Future<StudyModel> callCreateApi(
    String studyName,
    int max,
    int isPrivate,
    String password,
    String explanation,
    List<int> categories,
  ) async {
    Map<String, dynamic> studyCreateDtoJson = NewStudyInfo(
      studyName: studyName,
      max: max,
      isPrivate: isPrivate,
      password: password,
      explanation: explanation,
      categories: categories,
    ).toJson();

    try {
      debugPrint('[API]');
      final response = await _api.create(
        studyCreateDtoJson,
      );
      // print(response);
      return response;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }
}
