// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searched_study_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchedStudyInfoImpl _$$SearchedStudyInfoImplFromJson(
        Map<String, dynamic> json) =>
    _$SearchedStudyInfoImpl(
      id: json['id'] as int,
      teamName: json['teamName'] as String?,
      max: json['max'] as int,
      headcount: json['headcount'] as int,
      password: json['password'] as String,
      explanation: json['explanation'] as String,
      createdDate: json['createdDate'] as String,
      deadline: json['deadline'] as String,
      leaderId: json['leaderId'] as int,
      studyImage: json['studyImage'] as String?,
      categories: (json['categories'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      meetingSchedules: (json['meetingSchedules'] as List<dynamic>)
          .map((e) => MeetingInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      private: json['private'] as bool,
      finished: json['finished'] as bool,
    );

Map<String, dynamic> _$$SearchedStudyInfoImplToJson(
        _$SearchedStudyInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teamName': instance.teamName,
      'max': instance.max,
      'headcount': instance.headcount,
      'password': instance.password,
      'explanation': instance.explanation,
      'createdDate': instance.createdDate,
      'deadline': instance.deadline,
      'leaderId': instance.leaderId,
      'studyImage': instance.studyImage,
      'categories': instance.categories,
      'meetingSchedules': instance.meetingSchedules,
      'private': instance.private,
      'finished': instance.finished,
    };

_$MeetingInfoImpl _$$MeetingInfoImplFromJson(Map<String, dynamic> json) =>
    _$MeetingInfoImpl(
      id: json['id'] as int,
      day: json['day'] as int,
      startTime: json['startTime'] as String,
      endTime: json['endTime'] as String,
    );

Map<String, dynamic> _$$MeetingInfoImplToJson(_$MeetingInfoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'day': instance.day,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
