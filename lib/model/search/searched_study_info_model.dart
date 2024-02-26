import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_study_info_model.freezed.dart';
part 'searched_study_info_model.g.dart';

@freezed
class SearchedStudyInfo with _$SearchedStudyInfo {
  const factory SearchedStudyInfo({
    required int id,
    required String studyName,
    required int max,
    required int headcount,
    required String explanation,
    required String createdAt,
    required String? deadline,
    required String? studyImage,
    required List<String> categories,
    required List<MeetingInfo> meetingSchedules,
    required bool private,
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
