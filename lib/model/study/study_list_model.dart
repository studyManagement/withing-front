import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modi/model/study/study_meeting_schedules_model.dart';

part 'study_list_model.freezed.dart';
part 'study_list_model.g.dart';

@freezed
class StudyListModel with _$StudyListModel {
  const factory StudyListModel({
    required int id,
    required String studyName,
    required int max,
    required int headcount,
    required bool private,
    required String? studyImage,
    required String explanation,
    required DateTime createdAt,
    required List<String> categories,
    required List<StudyMeetingSchedulesModel> meetingSchedules,
  }) = _StudyListModel;

  factory StudyListModel.fromJson(Map<String, dynamic> json) =>
      _$StudyListModelFromJson(json);
}
