import 'package:freezed_annotation/freezed_annotation.dart';

part 'study_info_model.freezed.dart';
part 'study_info_model.g.dart';


// 스터디 상세보기 data
// @freezed
// class StudyInfoModel with _$StudyInfoModel {
//   const factory StudyInfoModel({
//     required int code,
//     required String message,
//     required bool success,
//     required StudyInfo data,
//
//   }) = _StudyInfoModel;
//
//   factory StudyInfoModel.fromJson(Map<String, dynamic> json) =>
//       _$StudyInfoModelFromJson(json);
// }
@freezed
class StudyInfo with _$StudyInfo {
  const factory StudyInfo({
    required int studyId,
    required String studyName,
    required int max,
    required int headcount,
    required int isPrivate,
    required int isFinished,
    required String explanation,
    required String createdDate,
    required String deadline,
    required int leaderId,
    required String studyImage,
  }) = _StudyInfo;

  factory StudyInfo.fromJson(Map<String, dynamic> json) =>
      _$StudyInfoFromJson(json);
}



