import 'package:freezed_annotation/freezed_annotation.dart';
part 'study_category_model.freezed.dart';
part 'study_category_model.g.dart';


// 스터디 카테고리 data
// @freezed
// class StudyCategoryModel with _$StudyCategoryModel {
//   const factory StudyCategoryModel({
//     required int code,
//     required String message,
//     required bool success,
//     required StudyCategories data,
//   }) = _StudyCategoryModel;
//
//   factory StudyCategoryModel.fromJson(Map<String, dynamic> json) =>
//       _$StudyCategoryModelFromJson(json);
// }
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

