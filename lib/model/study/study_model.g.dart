// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyModelImpl _$$StudyModelImplFromJson(Map<String, dynamic> json) =>
    _$StudyModelImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      isPrivate: json['isPrivate'] as int,
      isFinished: json['isFinished'] as int,
      explanation: json['explanation'] as String,
      createdDate: DateTime.parse(json['createdDate'] as String),
      deadline: DateTime.parse(json['deadline'] as String),
      leaderId: json['leaderId'] as int,
      studyImage: json['studyImage'] as String?,
      regularMeeting: json['regularMeeting'] as String?,
    );

Map<String, dynamic> _$$StudyModelImplToJson(_$StudyModelImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'isPrivate': instance.isPrivate,
      'isFinished': instance.isFinished,
      'explanation': instance.explanation,
      'createdDate': instance.createdDate.toIso8601String(),
      'deadline': instance.deadline.toIso8601String(),
      'leaderId': instance.leaderId,
      'studyImage': instance.studyImage,
      'regularMeeting': instance.regularMeeting,
    };
