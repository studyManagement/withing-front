// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_vote_item_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleVoteItemStatusModelImpl _$$ScheduleVoteItemStatusModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleVoteItemStatusModelImpl(
      id: json['id'] as int,
      studyId: json['studyId'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      selectedTime:
          const TimeOfDayConverter().fromJson(json['selectedTime'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduleVoteItemStatusModelImplToJson(
        _$ScheduleVoteItemStatusModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'user': instance.user,
      'selectedTime': const TimeOfDayConverter().toJson(instance.selectedTime),
      'createdAt': instance.createdAt.toIso8601String(),
    };
