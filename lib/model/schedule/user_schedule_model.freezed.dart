// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserScheduleModel _$UserScheduleModelFromJson(Map<String, dynamic> json) {
  return _UserScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$UserScheduleModel {
  String get date => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  String get scheduleName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserScheduleModelCopyWith<UserScheduleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserScheduleModelCopyWith<$Res> {
  factory $UserScheduleModelCopyWith(
          UserScheduleModel value, $Res Function(UserScheduleModel) then) =
      _$UserScheduleModelCopyWithImpl<$Res, UserScheduleModel>;
  @useResult
  $Res call(
      {String date,
      String startTime,
      String endTime,
      String studyName,
      String scheduleName});
}

/// @nodoc
class _$UserScheduleModelCopyWithImpl<$Res, $Val extends UserScheduleModel>
    implements $UserScheduleModelCopyWith<$Res> {
  _$UserScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? studyName = null,
    Object? scheduleName = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleName: null == scheduleName
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserScheduleModelImplCopyWith<$Res>
    implements $UserScheduleModelCopyWith<$Res> {
  factory _$$UserScheduleModelImplCopyWith(_$UserScheduleModelImpl value,
          $Res Function(_$UserScheduleModelImpl) then) =
      __$$UserScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String startTime,
      String endTime,
      String studyName,
      String scheduleName});
}

/// @nodoc
class __$$UserScheduleModelImplCopyWithImpl<$Res>
    extends _$UserScheduleModelCopyWithImpl<$Res, _$UserScheduleModelImpl>
    implements _$$UserScheduleModelImplCopyWith<$Res> {
  __$$UserScheduleModelImplCopyWithImpl(_$UserScheduleModelImpl _value,
      $Res Function(_$UserScheduleModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? studyName = null,
    Object? scheduleName = null,
  }) {
    return _then(_$UserScheduleModelImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      scheduleName: null == scheduleName
          ? _value.scheduleName
          : scheduleName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserScheduleModelImpl implements _UserScheduleModel {
  const _$UserScheduleModelImpl(
      {required this.date,
      required this.startTime,
      required this.endTime,
      required this.studyName,
      required this.scheduleName});

  factory _$UserScheduleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserScheduleModelImplFromJson(json);

  @override
  final String date;
  @override
  final String startTime;
  @override
  final String endTime;
  @override
  final String studyName;
  @override
  final String scheduleName;

  @override
  String toString() {
    return 'UserScheduleModel(date: $date, startTime: $startTime, endTime: $endTime, studyName: $studyName, scheduleName: $scheduleName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserScheduleModelImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.scheduleName, scheduleName) ||
                other.scheduleName == scheduleName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, date, startTime, endTime, studyName, scheduleName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserScheduleModelImplCopyWith<_$UserScheduleModelImpl> get copyWith =>
      __$$UserScheduleModelImplCopyWithImpl<_$UserScheduleModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserScheduleModelImplToJson(
      this,
    );
  }
}

abstract class _UserScheduleModel implements UserScheduleModel {
  const factory _UserScheduleModel(
      {required final String date,
      required final String startTime,
      required final String endTime,
      required final String studyName,
      required final String scheduleName}) = _$UserScheduleModelImpl;

  factory _UserScheduleModel.fromJson(Map<String, dynamic> json) =
      _$UserScheduleModelImpl.fromJson;

  @override
  String get date;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  String get studyName;
  @override
  String get scheduleName;
  @override
  @JsonKey(ignore: true)
  _$$UserScheduleModelImplCopyWith<_$UserScheduleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
