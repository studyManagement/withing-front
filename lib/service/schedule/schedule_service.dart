import 'package:dio/dio.dart' hide Headers;
import 'package:modi/model/schedule/schedule_detail_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:retrofit/http.dart';

import '../../common/requester/network_exception.dart';

part 'schedule_service.g.dart';

@RestApi()
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;

  @GET('/studies/{id}/schedules')
  Future<List<ScheduleModel>> fetchStudySchedules(@Path('id') int id);

  @GET('/studies/{id}/schedules/{studyScheduleId}')
  Future<ScheduleDetailModel> fetchStudySchedule(
      @Path('id') int id, @Path('studyScheduleId') int studyScheduleId);

  @POST('/studies/{id}/schedules')
  Future<ScheduleModel> postStudySchedule(
    @Path('id') int id,
    @Field('name') String title,
    @Field('description') String description,
    @Field('startDate') String startAt,
    @Field('endDate') String endAt,
  );

  @DELETE('/studies/{id}/schedules/{scheduleId}')
  Future<ScheduleModel> deleteStudySchedule(
    @Path('id') int id,
    @Path('scheduleId') int scheduleId,
  );
}

class ScheduleService {
  final ScheduleApi _scheduleApi;

  ScheduleService(this._scheduleApi);

  Future<List<ScheduleModel>> fetchSchedules(int studyId) async {
    try {
      return await _scheduleApi.fetchStudySchedules(studyId);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleDetailModel> fetchSchedule(
      int studyId, int studyScheduleId) async {
    try {
      return await _scheduleApi.fetchStudySchedule(studyId, studyScheduleId);
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleModel> postStudySchedule(int studyId, String title,
      String description, DateTime startAt, DateTime endAt) async {
    try {
      return await _scheduleApi.postStudySchedule(studyId, title, description,
          startAt.toIso8601String(), endAt.toIso8601String());
    } on DioException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleModel> deleteStudySchedule(
      int studyId, int studyScheduleId) async {
    try {
      return await _scheduleApi.deleteStudySchedule(studyId, studyScheduleId);
    } on DioException catch (e) {
      rethrow;
    }
  }
}
