// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signin_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SigninModel _$SigninModelFromJson(Map<String, dynamic> json) {
  return _SigninModel.fromJson(json);
}

/// @nodoc
mixin _$SigninModel {
  String get accessToken => throw _privateConstructorUsedError;
  String get refreshToken => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SigninModelCopyWith<SigninModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SigninModelCopyWith<$Res> {
  factory $SigninModelCopyWith(
          SigninModel value, $Res Function(SigninModel) then) =
      _$SigninModelCopyWithImpl<$Res, SigninModel>;
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class _$SigninModelCopyWithImpl<$Res, $Val extends SigninModel>
    implements $SigninModelCopyWith<$Res> {
  _$SigninModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_value.copyWith(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SigninModelImplCopyWith<$Res>
    implements $SigninModelCopyWith<$Res> {
  factory _$$SigninModelImplCopyWith(
          _$SigninModelImpl value, $Res Function(_$SigninModelImpl) then) =
      __$$SigninModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String accessToken, String refreshToken});
}

/// @nodoc
class __$$SigninModelImplCopyWithImpl<$Res>
    extends _$SigninModelCopyWithImpl<$Res, _$SigninModelImpl>
    implements _$$SigninModelImplCopyWith<$Res> {
  __$$SigninModelImplCopyWithImpl(
      _$SigninModelImpl _value, $Res Function(_$SigninModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accessToken = null,
    Object? refreshToken = null,
  }) {
    return _then(_$SigninModelImpl(
      accessToken: null == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String,
      refreshToken: null == refreshToken
          ? _value.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SigninModelImpl implements _SigninModel {
  const _$SigninModelImpl(
      {required this.accessToken, required this.refreshToken});

  factory _$SigninModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SigninModelImplFromJson(json);

  @override
  final String accessToken;
  @override
  final String refreshToken;

  @override
  String toString() {
    return 'SigninModel(accessToken: $accessToken, refreshToken: $refreshToken)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SigninModelImpl &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, accessToken, refreshToken);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SigninModelImplCopyWith<_$SigninModelImpl> get copyWith =>
      __$$SigninModelImplCopyWithImpl<_$SigninModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SigninModelImplToJson(
      this,
    );
  }
}

abstract class _SigninModel implements SigninModel {
  const factory _SigninModel(
      {required final String accessToken,
      required final String refreshToken}) = _$SigninModelImpl;

  factory _SigninModel.fromJson(Map<String, dynamic> json) =
      _$SigninModelImpl.fromJson;

  @override
  String get accessToken;
  @override
  String get refreshToken;
  @override
  @JsonKey(ignore: true)
  _$$SigninModelImplCopyWith<_$SigninModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
