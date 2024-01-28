import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_meeting_schedules_model.freezed.dart';
part 'study_meeting_schedules_model.g.dart';

@freezed
class StudyMeetingSchedulesModel with _$StudyMeetingSchedulesModel {
  const factory StudyMeetingSchedulesModel({
    required int id,
    required int day,
    required String startTime,
    required String endTime,
  }) = _StudyMeetingSchedulesModel;

  factory StudyMeetingSchedulesModel.fromJson(Map<String, dynamic> json) =>
      _$StudyMeetingSchedulesModelFromJson(json);
}
