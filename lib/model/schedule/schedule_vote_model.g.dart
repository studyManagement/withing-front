// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_vote_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleVoteModelImpl _$$ScheduleVoteModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleVoteModelImpl(
      id: json['id'] as int,
      studyId: json['studyId'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      votes: (json['votes'] as List<dynamic>)
          .map((e) => ScheduleVoteItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduleVoteModelImplToJson(
        _$ScheduleVoteModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'user': instance.user,
      'title': instance.title,
      'description': instance.description,
      'votes': instance.votes,
      'createdAt': instance.createdAt.toIso8601String(),
    };
