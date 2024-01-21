import 'package:freezed_annotation/freezed_annotation.dart';

part 'regular_meeting_model.freezed.dart';
part 'regular_meeting_model.g.dart';

@freezed
class RegularMeetingModel with _$RegularMeetingModel {
  const factory RegularMeetingModel({
    required int studyId,
    required int gap,
    required List<int> days,
    required String startTime,
    required String endTime,
  }) = _RegularMeetingModel;

  factory RegularMeetingModel.fromJson(Map<String, dynamic> json) =>
      _$RegularMeetingModelFromJson(json);
}
