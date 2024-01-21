// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'created_study_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CreatedStudyInfoImpl _$$CreatedStudyInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$CreatedStudyInfoImpl(
      studyId: json['studyId'] as int,
      studyName: json['studyName'] as String,
      max: json['max'] as int,
      headCount: json['headcount'] as int,
      isPrivate: json['isPrivate'] as int,
      password: json['password'] as String,
      explanation: json['explanation'] as String,
      createdDate: json['createdDate'] as String,
      deadline: json['deadline'] as String,
      leaderId: json['leaderId'] as int,
      categories:
          (json['categories'] as List<dynamic>).map((e) => e as int).toList(),
      studyImage: json['studyImage'] as String?,
    );

Map<String, dynamic> _$$CreatedStudyInfoImplToJson(
        _$CreatedStudyInfoImpl instance) =>
    <String, dynamic>{
      'studyId': instance.studyId,
      'studyName': instance.studyName,
      'max': instance.max,
      'headcount': instance.headCount,
      'isPrivate': instance.isPrivate,
      'password': instance.password,
      'explanation': instance.explanation,
      'createdDate': instance.createdDate,
      'deadline': instance.deadline,
      'leaderId': instance.leaderId,
      'categories': instance.categories,
      'studyImage': instance.studyImage,
    };
