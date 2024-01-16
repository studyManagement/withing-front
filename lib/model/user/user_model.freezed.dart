// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  int get userId => throw _privateConstructorUsedError;
  String get socialId => throw _privateConstructorUsedError;
  String get socialIdType => throw _privateConstructorUsedError;
  String get nickname => throw _privateConstructorUsedError;
  String get introduce => throw _privateConstructorUsedError;
  String get userImage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserModelCopyWith<UserModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {int userId,
      String socialId,
      String socialIdType,
      String nickname,
      String introduce,
      String userImage});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? socialId = null,
    Object? socialIdType = null,
    Object? nickname = null,
    Object? introduce = null,
    Object? userImage = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      socialId: null == socialId
          ? _value.socialId
          : socialId // ignore: cast_nullable_to_non_nullable
              as String,
      socialIdType: null == socialIdType
          ? _value.socialIdType
          : socialIdType // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      userImage: null == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(
          _$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int userId,
      String socialId,
      String socialIdType,
      String nickname,
      String introduce,
      String userImage});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res>
    extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(
      _$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? socialId = null,
    Object? socialIdType = null,
    Object? nickname = null,
    Object? introduce = null,
    Object? userImage = null,
  }) {
    return _then(_$UserModelImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as int,
      socialId: null == socialId
          ? _value.socialId
          : socialId // ignore: cast_nullable_to_non_nullable
              as String,
      socialIdType: null == socialIdType
          ? _value.socialIdType
          : socialIdType // ignore: cast_nullable_to_non_nullable
              as String,
      nickname: null == nickname
          ? _value.nickname
          : nickname // ignore: cast_nullable_to_non_nullable
              as String,
      introduce: null == introduce
          ? _value.introduce
          : introduce // ignore: cast_nullable_to_non_nullable
              as String,
      userImage: null == userImage
          ? _value.userImage
          : userImage // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl implements _UserModel {
  const _$UserModelImpl(
      {required this.userId,
      required this.socialId,
      required this.socialIdType,
      required this.nickname,
      required this.introduce,
      required this.userImage});

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserModelImplFromJson(json);

  @override
  final int userId;
  @override
  final String socialId;
  @override
  final String socialIdType;
  @override
  final String nickname;
  @override
  final String introduce;
  @override
  final String userImage;

  @override
  String toString() {
    return 'UserModel(userId: $userId, socialId: $socialId, socialIdType: $socialIdType, nickname: $nickname, introduce: $introduce, userImage: $userImage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.socialId, socialId) ||
                other.socialId == socialId) &&
            (identical(other.socialIdType, socialIdType) ||
                other.socialIdType == socialIdType) &&
            (identical(other.nickname, nickname) ||
                other.nickname == nickname) &&
            (identical(other.introduce, introduce) ||
                other.introduce == introduce) &&
            (identical(other.userImage, userImage) ||
                other.userImage == userImage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, userId, socialId, socialIdType,
      nickname, introduce, userImage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel implements UserModel {
  const factory _UserModel(
      {required final int userId,
      required final String socialId,
      required final String socialIdType,
      required final String nickname,
      required final String introduce,
      required final String userImage}) = _$UserModelImpl;

  factory _UserModel.fromJson(Map<String, dynamic> json) =
      _$UserModelImpl.fromJson;

  @override
  int get userId;
  @override
  String get socialId;
  @override
  String get socialIdType;
  @override
  String get nickname;
  @override
  String get introduce;
  @override
  String get userImage;
  @override
  @JsonKey(ignore: true)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
