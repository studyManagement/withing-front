import 'dart:developer';

import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:withing/common/requester/api_exception.dart';
import 'package:withing/common/requester/network_exception.dart';
import 'package:withing/model/study/notice_model.dart';
import 'package:withing/model/study/regular_meeting_exception.dart';
import 'package:withing/model/study/regular_meeting_model.dart';
import 'package:withing/model/study/study_category_model.dart';
import 'package:withing/model/study/study_exception.dart';
import 'package:withing/model/study/study_list_model.dart';
import 'package:withing/model/study/study_model.dart';
import 'package:withing/service/study/StudyType.dart';

part 'study_service.g.dart';

@RestApi()
abstract class StudyApi {
  factory StudyApi(Dio dio, {String baseUrl}) = _StudyApi;

  @GET("/studies")
  Future<List<StudyListModel>> fetchMyStudies(@Query("key") String key);

  // 삭제
  @GET('/studies/{id}/regular_meeting')
  Future<RegularMeetingModel> fetchRegularMeeting(@Path('id') int id);

  @GET('/studies/{id}')
  Future<StudyModel> fetchStudyInfo(@Path('id') int id);

  // 삭제
  @GET('/studies/{id}/categories')
  Future<StudyCategory> fetchStudyCategory(@Path('id') int id);

  // 삭제
  @GET('/studies/{id}/boards')
  Future<List<NoticeModel>> fetchBoards(
      @Path("id") int id, @Query("isNotice") bool isNotice);

  @PATCH('/studies/{id}/finish')
  Future<StudyModel> finishStudy(@Path('id') int id);

  @PATCH('/studies/{id}/members/{user_id}')
  Future<StudyModel> switchLeader(
      @Path('id') int id, @Path('user_id') int userId);

  @DELETE('/studies/{id}')
  Future<StudyModel> deleteStudy(@Path('id') int id);
}

class StudyService {
  final StudyApi _studyApi;

  StudyService(this._studyApi);

  Future<List<StudyListModel>> fetchMyStudies(StudyType studyType) async {
    try {
      final List<StudyListModel> myStudies =
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
    } on ApiException catch (e) {
      if (e.code == 404) {
        throw StudyException(e.cause);
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<StudyCategory> fetchStudyCategory(int studyId) async {
    final StudyCategory categoryData =
        await _studyApi.fetchStudyCategory(studyId);

    log('[DEBUG] ${categoryData.toString()}');
    return categoryData;
  }

  Future<List<NoticeModel>> fetchBoards(int studyId, bool isNotice) async {
    try {
      final List<NoticeModel> notices =
          await _studyApi.fetchBoards(studyId, isNotice);
      return notices;
    } on ApiException catch (e) {
      // if (e.code == 404) {
      //   //throw List.empty();
      // }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<StudyModel> finishStudy(int studyId) async {
    try {
      final StudyModel study = await _studyApi.finishStudy(studyId);
      print('Finished studyId: ${study.id}');
      return study;
    } on ApiException catch (e) {
      if (e.code == 400) {
        // 이미 종료
        print(e);
        rethrow;
      } else if (e.code == 401) {
        // accessToken 만료
        print(e);
        rethrow;
      } else if (e.code == 404) {
        // studyId 오류
        print(e);
      }
      rethrow;
    } on NetworkException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<StudyModel> deleteStudy(int studyId) async {
    try {
      final StudyModel study = await _studyApi.deleteStudy(studyId);
      print('Removed studyId: ${study.id}');
      return study;
    } on ApiException catch (e) {
      if (e.code == 404) {
        // studyId 오류
        print(e);
        rethrow;
      }
      rethrow;
    } on NetworkException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<StudyModel> switchLeader(int studyId, int userId) async {
    try {
      final StudyModel study = await _studyApi.switchLeader(studyId, userId);
      print('Switched leaderId: ${study.leaderId}');
      return study;
    } on ApiException catch (e) {
      if (e.code == 401) {
        // accessToken error
        print(e);
        rethrow;
      }
      rethrow;
    } on NetworkException catch (e) {
      print(e.message);
      rethrow;
    }
  }
}
