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
    required String explanation,
    required int leaderId,
    required String? studyImage,
    required List<String> categories,
    required int gap,
    required List<int>? days,
    required String startTime,
  }) = _StudyModel;

  factory StudyModel.fromJson(Map<String, dynamic> json) =>
      _$StudyModelFromJson(json);
}
