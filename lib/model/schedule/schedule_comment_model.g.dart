// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_comment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleCommentModelImpl _$$ScheduleCommentModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ScheduleCommentModelImpl(
      id: json['id'] as int,
      studyId: json['studyId'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$$ScheduleCommentModelImplToJson(
        _$ScheduleCommentModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'studyId': instance.studyId,
      'user': instance.user,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
    };
