import 'dart:developer';
import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:modi/model/study/regular_meeting_exception.dart';
import 'package:modi/model/study/regular_meeting_model.dart';
import 'package:modi/model/study/study_category_model.dart';
import 'package:modi/model/study/study_exception.dart';
import 'package:modi/model/study/study_list_model.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/service/study/StudyType.dart';
import 'package:flutter/cupertino.dart';
import 'package:modi/view_models/study/model/updated_study_info.dart';
import 'package:retrofit/http.dart';
import '../../model/board/board_model.dart';
import '../../view_models/study/model/study_meeting_schedule.dart';

part 'study_service.g.dart';

@RestApi()
abstract class StudyApi {
  factory StudyApi(Dio dio, {String baseUrl}) = _StudyApi;

  @GET("/studies")
  Future<List<StudyListModel>> fetchMyStudies(@Query("key") String key);

  @GET('/studies/{id}')
  Future<StudyModel> fetchStudyInfo(@Path('id') int id);

  @PATCH('/studies/{id}')
  Future<StudyModel> updateStudyInfo(
      @Path('id') int id, @Body() Map<String, dynamic> data);

  @PATCH('/studies/{id}/finish')
  Future<StudyModel> finishStudy(@Path('id') int id);

  @DELETE('/studies/{id}')
  Future<StudyModel> deleteStudy(@Path('id') int id);

  @PATCH('/studies/{id}/members/{userId}')
  Future<StudyModel> switchLeader(
      @Path('id') int id, @Path('userId') int userId);

  @DELETE('/studies/{id}/admin/members')
  Future<dynamic> forceToExitMember(
      @Path('id') int id, @Body() Map<String, dynamic> data);

  @PATCH('/studies/{id}/members')
  Future<dynamic> joinStudy(
      @Path('id') int id, @Body() Map<String, dynamic> data);

  @POST('/studies/{id}/regular_meeting')
  Future<StudyModel> setMeetingSchedule(
      @Path('id') int id, @Body() List<StudyMeetingSchedule> data);
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

  Future<StudyModel> fetchStudyInfo(int studyId) async {
    try {
      final StudyModel study = await _studyApi.fetchStudyInfo(studyId);
      return study;
    } on ApiException catch (e) {
      if (e.code == 404) {
        throw StudyException(e.cause, e.code);
      }
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

  Future<StudyModel> updateStudyInfo(
      int studyId, UpdatedStudyInfo newStudy) async {
    try {
      final StudyModel study =
          await _studyApi.updateStudyInfo(studyId, newStudy.toJson());
      return study;
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
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
      print('[API]:Switched leaderId ${study.leaderId}');
      return study;
    } on ApiException catch (e) {
      if (e.code == 401 || e.code == 400 || e.code == 404) {
        // accessToken error
        debugPrint('[API]:${e.cause}');
      }
      rethrow;
    } on NetworkException catch (e) {
      debugPrint('[API]:${e.cause}');
      rethrow;
    }
  }

  Future<dynamic> forceToExitMember(int studyId, List<int> users) async {
    try {
      var response =
          await _studyApi.forceToExitMember(studyId, {"users": users});
      return response;
    } on ApiException catch (e) {
      if (e.code == 404) {
        throw StudyException(e.cause, e.code);
      } else if (e.code == 401) {
        debugPrint('[API]: ${e.cause}');
      }
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<dynamic> joinStudy(int studyId, String? password) async {
    try {
      var response = await _studyApi.joinStudy(studyId, {"password": password});
      return response;
    } on ApiException catch (e) {
      if (e.code == 400 || e.code == 404) {
        debugPrint('[API]: ${e.cause}');
        throw StudyException(e.cause, e.code);
      }
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<StudyModel> setMeetingSchedule(
      int studyId, List<StudyMeetingSchedule> meetingSchedules) async {
    meetingSchedules.map((e) => e.toJson()).toList();
    try {
      final StudyModel study =
          await _studyApi.setMeetingSchedule(studyId, meetingSchedules);
      return study;
    } on ApiException catch (e) {
      if (e.code == 404 || e.code == 400) {
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
