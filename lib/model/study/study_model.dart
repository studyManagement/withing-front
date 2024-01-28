import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:withing/model/study/study_meeting_schedules_model.dart';
import 'package:withing/model/user/user_model.dart';

part 'study_model.freezed.dart';
part 'study_model.g.dart';

@freezed
class StudyModel with _$StudyModel {
  const factory StudyModel({
    required int id,
    required String studyName,
    required int max,
    required int headcount,
    required bool private,
    required bool finished,
    required String explanation,
    required int leaderId,
    required DateTime createdAt,
    required DateTime? deadline,
    required String studyImage,
    required List<String> categories,
    required List<StudyMeetingSchedulesModel> meetingSchedules,
    required List<UserModel> users,
  }) = _StudyModel;

  factory StudyModel.fromJson(Map<String, dynamic> json) =>
      _$StudyModelFromJson(json);
}
