// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardModelImpl _$$BoardModelImplFromJson(Map<String, dynamic> json) =>
    _$BoardModelImpl(
      id: json['id'] as int,
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      title: json['title'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      numOfComments: json['numOfComments'] as int,
      notice: json['notice'] as bool,
    );

Map<String, dynamic> _$$BoardModelImplToJson(_$BoardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'title': instance.title,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'numOfComments': instance.numOfComments,
      'notice': instance.notice,
    };
