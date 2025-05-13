// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'board_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BoardModelImpl _$$BoardModelImplFromJson(Map<String, dynamic> json) =>
    _$BoardModelImpl(
      id: (json['id'] as num).toInt(),
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      category: json['category'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      images:
          (json['images'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      numOfComments: (json['numOfComments'] as num).toInt(),
    );

Map<String, dynamic> _$$BoardModelImplToJson(_$BoardModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'category': instance.category,
      'title': instance.title,
      'content': instance.content,
      'images': instance.images,
      'createdAt': instance.createdAt.toIso8601String(),
      'numOfComments': instance.numOfComments,
    };
