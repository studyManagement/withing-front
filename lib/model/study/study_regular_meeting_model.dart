import 'package:freezed_annotation/freezed_annotation.dart';
part 'study_regular_meeting_model.freezed.dart';
part 'study_regular_meeting_model.g.dart';


// 스터디 정기 모임 data
// @freezed
// class StudyRegularMeetingModel with _$StudyRegularMeetingModel {
//   const factory StudyRegularMeetingModel({
//     required int code,
//     required String message,
//     required bool success,
//     StudyRegularMeeting? data, // 정기 모임 없을 수 있음
//   }) = _StudyRegularMeetingModel;
//
//   factory StudyRegularMeetingModel.fromJson(Map<String, dynamic> json) =>
//       _$StudyRegularMeetingModelFromJson(json);
// }
@freezed
class StudyRegularMeeting with _$StudyRegularMeeting {
  const factory StudyRegularMeeting({
    required int regularMeetingId,
    required int gap,
    required int day1,
    required int day2,
    required int day3,
    required String startTime,
    required String endTime,
  }) = _StudyRegularMeeting;

  factory StudyRegularMeeting.fromJson(Map<String, dynamic> json) =>
      _$StudyRegularMeetingFromJson(json);
}




