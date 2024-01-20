import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_model.freezed.dart';
part 'study_model.g.dart';

@freezed
class StudyModel with _$StudyModel {
  const factory StudyModel({
    required int studyId,
    required String studyName,
    required int max,
    required int headcount,
    required int isPrivate,
    required int isFinished,
    required String explanation,
    required DateTime createdDate,
    required DateTime deadline,
    required int leaderId,
    required String? studyImage,
    required String? regularMeeting,
  }) = _StudyModel;

  factory StudyModel.fromJson(Map<String, dynamic> json) =>
      _$StudyModelFromJson(json);
}
