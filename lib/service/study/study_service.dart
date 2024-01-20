import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/network_exception.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';

part 'study_service.g.dart';

@RestApi()
abstract class StudyApi {
  factory StudyApi(Dio dio, {String baseUrl}) = _StudyApi;

  @GET("/studies/users/20")
  Future<List<StudyModel>> fetchMyStudies(@Query("key") String key);

  @GET('/studies/{id}/regular_meeting')
  Future<RegularMeetingModel> fetchRegularMeeting(@Path('id') int id);
}

class StudyService {
  final StudyApi _studyApi;
  StudyService(this._studyApi);

  Future<List<StudyModel>> fetchMyStudies(StudyType studyType) async {
    try {
      final List<StudyModel> myStudies =
          await _studyApi.fetchMyStudies(studyType.key);
      return myStudies;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<RegularMeetingModel> fetchRegularMeeting(int studyId) async {
    try {
      return await _studyApi.fetchRegularMeeting(studyId);
    } on ApiException catch (e) {
      if (e.code == 400 || e.code == 404) {
        throw RegularMeetingException(e.cause);
      }

      rethrow;
    }
  }
}
