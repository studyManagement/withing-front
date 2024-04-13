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
      startAt: DateTime.parse(json['startAt'] as String),
      endAt: DateTime.parse(json['endAt'] as String),
      votes: (json['votes'] as List<dynamic>)
          .map((e) => ScheduleVoteItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduleVoteItemModelImplToJson(
        _$ScheduleVoteItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'voteDay': instance.voteDay.toIso8601String(),
      'startAt': instance.startAt.toIso8601String(),
      'endAt': instance.endAt.toIso8601String(),
      'votes': instance.votes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
