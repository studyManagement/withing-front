// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'study_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StudyInfoImpl _$$StudyInfoImplFromJson(Map<String, dynamic> json) =>
    _$StudyInfoImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      isPrivate: json['isPrivate'] as int,
      isFinished: json['isFinished'] as int,
      explanation: json['explanation'] as String,
      createdDate: json['createdDate'] as String,
      deadline: json['deadline'] as String,
      leaderId: json['leaderId'] as int,
      studyImage: json['studyImage'] as String,
    );

Map<String, dynamic> _$$StudyInfoImplToJson(_$StudyInfoImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headcount,
      'isPrivate': instance.isPrivate,
      'isFinished': instance.isFinished,
      'explanation': instance.explanation,
      'createdDate': instance.createdDate,
      'deadline': instance.deadline,
      'leaderId': instance.leaderId,
      'studyImage': instance.studyImage,
    };
