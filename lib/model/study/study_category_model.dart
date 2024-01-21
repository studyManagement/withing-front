import 'package:freezed_annotation/freezed_annotation.dart';
part 'study_category_model.freezed.dart';
part 'study_category_model.g.dart';

@freezed
class StudyCategory with _$StudyCategory {
  const factory StudyCategory({
    required int studyId,
    required String? category1,
    required String? category2,
    required String? category3,
  }) = _StudyCategory;

  factory StudyCategory.fromJson(Map<String, dynamic> json) =>
      _$StudyCategoryFromJson(json);
}

