import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/image/image_exception.dart';
import 'package:modi/exception/study/study_exception.dart';
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';
import '../../model/create/new_study_info_model.dart';
import '../../model/study/study_model.dart';

part 'study_create_service.g.dart';

/// API
@RestApi()
abstract class StudyCreateApi {
  factory StudyCreateApi(Dio dio, {String baseUrl}) = _StudyCreateApi;

  @POST("/studies")
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
      String uuid) async {
    Map<String, dynamic> studyCreateDtoJson = NewStudyInfo(
      studyName: studyName,
      max: max,
      isPrivate: isPrivate,
      password: password,
      explanation: explanation,
      categories: categories,
      uuid: uuid,
    ).toJson();

    try {
      final response = await _api.create(
        studyCreateDtoJson,
      );
      return response;
    } on ApiException catch (e){
      throw StudyException(e.cause, e.code);
    }
    on NetworkException catch (e) {
      rethrow;
    }
  }
}
