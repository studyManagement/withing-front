import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';
//
// @freezed
// class NoticeListModel with _$NoticeListModel {
//   const factory NoticeListModel({
//     required List<NoticeModel> data
//   }) = _NoticeListModel;
//
//   factory NoticeListModel.fromJson(Map<String, dynamic> json) =>
//       _$NoticeListModelFromJson(json);
// }

@freezed
class NoticeModel with _$NoticeModel {
  const factory NoticeModel({
    required String createdAt,
    required String contents,
    required int boardId,
    required int studyId,
    required String title,
    required int userId,
    required int notice,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);
}