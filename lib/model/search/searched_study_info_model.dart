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
    required List<int> categories,
    required int? regularMeetingId,
    required int gap,
    required List<int> days,
    required String startTime, // LocalTime
    required String endTime, // LocalTime
  }) = _SearchedStudyInfo;

  factory SearchedStudyInfo.fromJson(Map<String, dynamic> json) =>
      _$SearchedStudyInfoFromJson(json);
}
