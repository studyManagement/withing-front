import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_study_info_model.freezed.dart';
part 'searched_study_info_model.g.dart';

@freezed
class SearchedStudyInfo with _$SearchedStudyInfo {
  const factory SearchedStudyInfo({
    required int studyId,
    required String studyName,
    required int max,
    @JsonKey(name: 'headcount') required int headCount,
    required String? studyImage,
    required List<String> categories,
    required int? regularMeetingId,
    required int gap,
    required int day1,
    required int day2,
    required int day3,
    required String startTime, // LocalTime
    required String endTime, // LocalTime
  }) = _SearchedStudyInfo;

  factory SearchedStudyInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchedStudyInfoFromJson(json);
}
