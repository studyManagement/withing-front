import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_study_info_model.freezed.dart';
part 'searched_study_info_model.g.dart';

@freezed
class SearchedStudyInfo with _$SearchedStudyInfo {
  const factory SearchedStudyInfo({
    required int id,
    required String? teamName,
    required int max,
    required int headcount,
    required String password,
    required String explanation,
    required String createdDate,
    required String deadline,
    required int leaderId,
    required String? studyImage,
    required List<String> categories,
    required MeetingInfo meetingSchedules,
    required bool private,
    required bool finished,
  }) = _SearchedStudyInfo;

  factory SearchedStudyInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchedStudyInfoFromJson(json);
}

@freezed
class MeetingInfo with _$MeetingInfo {
  const factory MeetingInfo({
    required int id,
    required int day,
    required String startTime,
    required String endTime,
  }) = _MeetingInfo;

  factory MeetingInfo.fromJson(Map<String, dynamic> json) =>
      _$MeetingInfoFromJson(json);
}
