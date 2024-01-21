import 'package:freezed_annotation/freezed_annotation.dart';

part 'created_study_info_model.freezed.dart';
part 'created_study_info_model.g.dart';

@freezed
class CreatedStudyInfo with _$CreatedStudyInfo {
  const factory CreatedStudyInfo({
    required int studyId,
    required String studyName,
    required int max,
    @JsonKey(name: 'headcount') required int headCount,
    required int isPrivate,
    required String password,
    required String explanation,
    required String createdDate,
    required String deadline,
    required int leaderId,
    required List<int> categories,
    required String? studyImage,
  }) = _CreatedStudyInfo;

  factory CreatedStudyInfo.fromJson(Map<String, dynamic> json) =>
      _$CreatedStudyInfoFromJson(json);
}
