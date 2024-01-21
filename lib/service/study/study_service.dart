import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/network_exception.dart';
import 'package:withing/model/study/notice_model.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_category_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';

part 'study_service.g.dart';

@RestApi()
abstract class StudyApi {
  factory StudyApi(Dio dio, {String baseUrl}) = _StudyApi;

  @GET("/studies/users")
  Future<List<StudyModel>> fetchMyStudies(@Query("key") String key);

  @GET('/studies/{id}/regular_meeting')
  Future<RegularMeetingModel> fetchRegularMeeting(@Path('id') int id);

  @GET('/studies/{id}')
  Future<StudyModel> fetchStudyInfo(@Path('id') int id);

  @GET('/studies/{id}/categories')
  Future<StudyCategory> fetchStudyCategory(@Path('id') int id);

  @GET('/studies/{id}/dashboard/notices')
  Future<List<NoticeModel>> fetchNotices(@Path("id") int id);
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

  Future<StudyModel> fetchStudyInfo(int studyId) async {
    try {
      final StudyModel study = await _studyApi.fetchStudyInfo(studyId);
      return study;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<StudyCategory> fetchStudyCategory(int studyId) async {
    final StudyCategory categoryData =
        await _studyApi.fetchStudyCategory(studyId);

    log('[DEBUG] ${categoryData.toString()}');
    return categoryData;
  }

  Future<List<NoticeModel>> fetchNotices(int studyId) async {
    try {
      final List<NoticeModel> notices = await _studyApi.fetchNotices(studyId);
      log('[DEBUG] ${notices.toString()}');
      return notices;
    } on ApiException catch (e) {
      log('[DEBUG] ${e.code}, ${e.message}');
      if (e.code == 404) {
        return List.empty();
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
