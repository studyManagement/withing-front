import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/model/study/study_category_model.dart';
import 'package:withing/model/study/study_info_model.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/model/study/study_regular_meeting_model.dart';

part 'study_service.g.dart';

@RestApi(baseUrl: "http://3.34.129.8:8080")

abstract class StudyApi {
  factory StudyApi(Dio dio, {String baseUrl}) = _StudyApi;
  @Headers(<String,String> {'Content-Type' : 'application/json'})

  @GET("/studies/{studyId}") // StudyInfo
  Future<StudyInfo> getStudyInfo(@Path("studyId") int studyId);

  @GET("/studies/{studyId}/category")
  Future<StudyCategory> getStudyCategory(@Path("studyId") int studyId);

  @GET("/studies/{studyId}/regular_meeting")
  Future<StudyRegularMeeting> getStudyRegularMeeting(@Path("studyId") int studyId);



}

class StudyService {
  final StudyApi _studyApi;

  StudyService(this._studyApi);

  Future<StudyInfo> callStudyInfoApi(int studyId) async {
    try {
      final response = await _studyApi.getStudyInfo(
        studyId,
      );
      return response;
    } on ApiException catch (e) {
      rethrow;
    }
  }


  Future<StudyCategory> callStudyCategoryApi(int studyId) async {
    try {
      final response = await _studyApi.getStudyCategory(
        studyId,
      );
      return response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

  Future<StudyRegularMeeting> callStudyRegularMeetingApi(int studyId) async {
    try {
      final response = await _studyApi.getStudyRegularMeeting(
        studyId,
      );
      return response;
    } on ApiException catch (e) {
      rethrow;
    }
  }

}


