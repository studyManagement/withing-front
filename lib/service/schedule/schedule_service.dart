import 'package:dio/dio.dart' hide Headers;
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/exception/signin/user_not_found_exception.dart';
import 'package:modi/model/schedule/schedule_detail_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';
import '../../model/schedule/user_schedule_model.dart';
import '../../model/schedule/vote_date_time_model.dart';

part 'schedule_service.g.dart';

@RestApi()
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;

/// Schedules

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

  @PUT('/studies/{id}/schedules/{schedule_id}')
  Future<ScheduleModel> putStudySchedule(
    @Path('id') int id,
    @Field('name') String title,
    @Path('schedule_id') int scheduleId,
    @Field('description') String description,
    @Field('startDate') String startAt,
    @Field('endDate') String endAt,
  );

  @DELETE('/studies/{id}/schedules/{scheduleId}')
  Future<List<ScheduleModel>> deleteStudySchedule(
    @Path('id') int id,
    @Path('scheduleId') int scheduleId,
  );


  /// Votes

  @GET('/studies/{id}/schedules/votes')
  Future<List<ScheduleVoteModel>> fetchScheduleVotes(@Path('id') int id);

  @GET('/studies/{id}/schedules/{voteId}/votes')
  Future<ScheduleVoteModel> fetchScheduleVote(
    @Path('id') int id,
    @Path('voteId') int voteId,
  );

  @POST('/studies/{id}/schedules/votes') // 투표 생성
  Future<ScheduleVoteModel> postScheduleVote(
    @Path('id') int id,
    @Field('name') String name,
    @Field('description') String description,
    @Field('selectedDates') List<String> selectedDates,
    @Field('startAt') String startAt,
    @Field('endAt') String endAt,
  );

  @POST('/studies/{id}/schedules/{schedule_id}/votes') // 투표 참여
  Future<ScheduleVoteModel> vote(
      @Path('id') int id,
      @Path('schedule_id') int scheduleId,
      @Body() List<VoteDateTimeModel> selectedList
      );

  @PUT('/studies/{id}/schedules/votes/{vote_id}')
  Future<ScheduleVoteModel> closeVote(
      @Path('id') int id,
      @Path('vote_id') int voteId,
      );

  @GET('/users/schedules')
  Future<List<UserScheduleModel>> fetchUserSchedule(
      @Query('date') String date, @Query('size') int size);

  @GET('/users/schedules/this-week')
  Future<List<UserScheduleModel>> fetchThisWeekSchedule();


}

class ScheduleService {
  final ScheduleApi _scheduleApi;

  ScheduleService(this._scheduleApi);

  Future<List<ScheduleVoteModel>> fetchScheduleVotes(int studyId) async {
    try {
      return await _scheduleApi.fetchScheduleVotes(studyId);
    } on ApiException catch (e){
      rethrow;
    }
    on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleVoteModel> fetchScheduleVote(int studyId, int voteId) async {
    try {
      return await _scheduleApi.fetchScheduleVote(studyId, voteId);
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleVoteModel> postScheduleVote(
    int studyId,
    String name,
    String description,
    List<DateTime> selectedDates,
    DateTime startAt,
    DateTime endAt,
  ) async {
    try {
      return await _scheduleApi.postScheduleVote(
        studyId,
        name,
        description,
        selectedDates.map((e) => e.toIso8601String()).toList(),
        startAt.toIso8601String(),
        endAt.toIso8601String(),
      );
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleVoteModel> vote(
      int studyId,
      int scheduleId,
      List<VoteDateTimeModel> selectedList
      ) async {
    try {
      return await _scheduleApi.vote(
        studyId,
        scheduleId,
        selectedList
      );
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleVoteModel> closeVote(
      int studyId,
      int voteId,
      ) async {
    try {
      return await _scheduleApi.closeVote(
          studyId,
          voteId
      );
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>> fetchSchedules(int studyId) async {
    try {
      return await _scheduleApi.fetchStudySchedules(studyId);
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleDetailModel> fetchSchedule(
      int studyId, int studyScheduleId) async {
    try {
      return await _scheduleApi.fetchStudySchedule(studyId, studyScheduleId);
    } on ApiException catch (e){
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleModel> postStudySchedule(int studyId, String title,
      String description, DateTime startAt, DateTime endAt) async {
    try {
      return await _scheduleApi.postStudySchedule(studyId, title, description,
          startAt.toIso8601String(), endAt.toIso8601String());
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<ScheduleModel> putStudySchedule(
      int studyId,
      int studyScheduleId,
      String title,
      String description,
      DateTime startAt,
      DateTime endAt) async {
    try {
      return await _scheduleApi.putStudySchedule(
          studyId,
          title,
          studyScheduleId,
          description,
          startAt.toIso8601String(),
          endAt.toIso8601String());
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<List<ScheduleModel>> deleteStudySchedule(
      int studyId, int studyScheduleId) async {
    try {
      return await _scheduleApi.deleteStudySchedule(studyId, studyScheduleId);
    } on ApiException catch (e) {
      rethrow;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<List<UserScheduleModel>> fetchUserSchedule(
      String date, int size) async{
    try{
      return await _scheduleApi.fetchUserSchedule(date, size);
    } on ApiException catch(e){
      rethrow;
    } on NetworkException catch (e){
      rethrow;
    }
  }

  Future<List<UserScheduleModel>> fetchThisWeekSchedule() async{
    try{
      return await _scheduleApi.fetchThisWeekSchedule();
    } on ApiException catch(e){
      rethrow;
    } on NetworkException catch (e){
      rethrow;
    }
  }

}
