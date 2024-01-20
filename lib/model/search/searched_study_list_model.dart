import 'package:freezed_annotation/freezed_annotation.dart';

part 'searched_study_list_model.freezed.dart';
part 'searched_study_list_model.g.dart';

@freezed
class StudyInfo with _$StudyInfo {
  const factory StudyInfo({
    required int studyId,
    required String studyName,
    required int max,
    @JsonKey(name: 'headcount') required int headCount,
    required String? studyImage,
    required List<String> categoryList,
    required int? regularMeetingId,
    required int gap,
    required int day1,
    required int day2,
    required int day3,
    required String startTime, // LocalTime
    required String endTime, // LocalTime
  }) = _StudyInfo;

  factory StudyInfo.fromJson(Map<String, dynamic> json) =>
      _$StudyInfoFromJson(json);
}
