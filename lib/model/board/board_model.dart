import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:withing/model/user/user_model.dart';

part 'board_model.freezed.dart';
part 'board_model.g.dart';

@freezed
class BoardModel with _$BoardModel {
  const factory BoardModel({
    required int id,
    required UserModel user,
    required String title,
    required String content,
    required DateTime createdAt,
    required bool notice,
  }) = _BoardModel;

  factory BoardModel.fromJson(Map<String, dynamic> json) =>
      _$BoardModelFromJson(json);
}