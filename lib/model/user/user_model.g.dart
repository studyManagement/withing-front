// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      userId: json['userId'] as int,
      socialId: json['socialId'] as String,
      socialIdType: json['socialIdType'] as String,
      nickname: json['nickname'] as String,
      introduce: json['introduce'] as String,
      userImage: json['userImage'] as String,
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'socialId': instance.socialId,
      'socialIdType': instance.socialIdType,
      'nickname': instance.nickname,
      'introduce': instance.introduce,
      'userImage': instance.userImage,
    };
