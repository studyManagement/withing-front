import 'package:dio/dio.dart' hide Headers;
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:retrofit/http.dart';

import '../../common/requester/network_exception.dart';

part 'schedule_service.g.dart';

@RestApi()
abstract class ScheduleApi {
  factory ScheduleApi(Dio dio, {String baseUrl}) = _ScheduleApi;

  @GET('/studies/{id}/schedules')
  Future<List<ScheduleModel>> fetchStudySchedules(@Path('id') int id);
}

class ScheduleService {
  final ScheduleApi _scheduleApi;

  ScheduleService(this._scheduleApi);

  Future<List<ScheduleModel>> fetchMyStudies(int studyId) async {
    try {
      return await _scheduleApi.fetchStudySchedules(studyId);
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
