// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CategorySearchModelImpl _$$CategorySearchModelImplFromJson(
        Map<String, dynamic> json) =>
    _$CategorySearchModelImpl(
      code: json['code'] as int,
      message: json['message'] as String,
      success: json['success'] as bool,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => StudyGroup.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CategorySearchModelImplToJson(
        _$CategorySearchModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'success': instance.success,
      'data': instance.data,
    };

_$StudyGroupImpl _$$StudyGroupImplFromJson(Map<String, dynamic> json) =>
    _$StudyGroupImpl(
      id: json['id'] as int,
      teamName: json['team_name'] as String,
      max: json['max'] as int,
      headCount: json['headcount'] as int,
      isPrivate: json['isPrivate'] as int,
      isFinished: json['isFinished'] as int,
      password: json['password'] as String,
      explanation: json['explanation'] as String,
      createdDate: json['created_date'] as String,
      deadline: json['deadline'] as String,
      leaderId: json['leader_id'] as int,
    );

Map<String, dynamic> _$$StudyGroupImplToJson(_$StudyGroupImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'team_name': instance.teamName,
      'max': instance.max,
      'headcount': instance.headCount,
      'isPrivate': instance.isPrivate,
      'isFinished': instance.isFinished,
      'password': instance.password,
      'explanation': instance.explanation,
      'created_date': instance.createdDate,
      'deadline': instance.deadline,
      'leader_id': instance.leaderId,
    };
