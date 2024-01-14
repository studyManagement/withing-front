import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_search_model.freezed.dart';
part 'category_search_model.g.dart';

@freezed
class CategorySearchModel with _$CategorySearchModel {
  const factory CategorySearchModel({
    required int code,
    required String message,
    required bool success,
    List<StudyGroup>? data,
  }) = _CategorySearchModel;

  factory CategorySearchModel.fromJson(Map<String, dynamic> json) =>
      _$CategorySearchModelFromJson(json);
}

@freezed
class StudyGroup with _$StudyGroup {
  const factory StudyGroup({
    required int id,
    @JsonKey(name: 'team_name') required String teamName,
    required int max,
    @JsonKey(name: 'headcount') required int headCount,
    required int isPrivate,
    required int isFinished,
    required String password,
    required String explanation,
    @JsonKey(name: 'created_date') required String createdDate,
    required String deadline,
    @JsonKey(name: 'leader_id') required int leaderId,
  }) = _StudyGroup;

  factory StudyGroup.fromJson(Map<String, dynamic> json) =>
      _$StudyGroupFromJson(json);
}
