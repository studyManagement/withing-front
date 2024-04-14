// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_vote_item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleVoteItemModelImpl _$$ScheduleVoteItemModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleVoteItemModelImpl(
      id: json['id'] as int,
      studyId: json['studyId'] as int,
      voteDay: DateTime.parse(json['voteDay'] as String),
      status: (json['status'] as List<dynamic>)
          .map((e) =>
              ScheduleVoteItemStatusModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      startAt: const TimeOfDayConverter().fromJson(json['startAt'] as String),
      endAt: const TimeOfDayConverter().fromJson(json['endAt'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduleVoteItemModelImplToJson(
        _$ScheduleVoteItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'voteDay': instance.voteDay.toIso8601String(),
      'status': instance.status,
      'startAt': const TimeOfDayConverter().toJson(instance.startAt),
      'endAt': const TimeOfDayConverter().toJson(instance.endAt),
      'createdAt': instance.createdAt.toIso8601String(),
    };
