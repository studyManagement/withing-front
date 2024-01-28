// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_meeting_schedules_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyMeetingSchedulesModel _$StudyMeetingSchedulesModelFromJson(
    Map<String, dynamic> json) {
  return _StudyMeetingSchedulesModel.fromJson(json);
}

/// @nodoc
mixin _$StudyMeetingSchedulesModel {
  int get id => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyMeetingSchedulesModelCopyWith<StudyMeetingSchedulesModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyMeetingSchedulesModelCopyWith<$Res> {
  factory $StudyMeetingSchedulesModelCopyWith(StudyMeetingSchedulesModel value,
          $Res Function(StudyMeetingSchedulesModel) then) =
      _$StudyMeetingSchedulesModelCopyWithImpl<$Res,
          StudyMeetingSchedulesModel>;
  @useResult
  $Res call({int id, int day, String startTime, String endTime});
}

/// @nodoc
class _$StudyMeetingSchedulesModelCopyWithImpl<$Res,
        $Val extends StudyMeetingSchedulesModel>
    implements $StudyMeetingSchedulesModelCopyWith<$Res> {
  _$StudyMeetingSchedulesModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyMeetingSchedulesModelImplCopyWith<$Res>
    implements $StudyMeetingSchedulesModelCopyWith<$Res> {
  factory _$$StudyMeetingSchedulesModelImplCopyWith(
          _$StudyMeetingSchedulesModelImpl value,
          $Res Function(_$StudyMeetingSchedulesModelImpl) then) =
      __$$StudyMeetingSchedulesModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int day, String startTime, String endTime});
}

/// @nodoc
class __$$StudyMeetingSchedulesModelImplCopyWithImpl<$Res>
    extends _$StudyMeetingSchedulesModelCopyWithImpl<$Res,
        _$StudyMeetingSchedulesModelImpl>
    implements _$$StudyMeetingSchedulesModelImplCopyWith<$Res> {
  __$$StudyMeetingSchedulesModelImplCopyWithImpl(
      _$StudyMeetingSchedulesModelImpl _value,
      $Res Function(_$StudyMeetingSchedulesModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$StudyMeetingSchedulesModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      day: null == day
          ? _value.day
          : day // ignore: cast_nullable_to_non_nullable
              as int,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyMeetingSchedulesModelImpl implements _StudyMeetingSchedulesModel {
  const _$StudyMeetingSchedulesModelImpl(
      {required this.id,
      required this.day,
      required this.startTime,
      required this.endTime});

  factory _$StudyMeetingSchedulesModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$StudyMeetingSchedulesModelImplFromJson(json);

  @override
  final int id;
  @override
  final int day;
  @override
  final String startTime;
  @override
  final String endTime;

  @override
  String toString() {
    return 'StudyMeetingSchedulesModel(id: $id, day: $day, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyMeetingSchedulesModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.day, day) || other.day == day) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, day, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyMeetingSchedulesModelImplCopyWith<_$StudyMeetingSchedulesModelImpl>
      get copyWith => __$$StudyMeetingSchedulesModelImplCopyWithImpl<
          _$StudyMeetingSchedulesModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyMeetingSchedulesModelImplToJson(
      this,
    );
  }
}

abstract class _StudyMeetingSchedulesModel
    implements StudyMeetingSchedulesModel {
  const factory _StudyMeetingSchedulesModel(
      {required final int id,
      required final int day,
      required final String startTime,
      required final String endTime}) = _$StudyMeetingSchedulesModelImpl;

  factory _StudyMeetingSchedulesModel.fromJson(Map<String, dynamic> json) =
      _$StudyMeetingSchedulesModelImpl.fromJson;

  @override
  int get id;
  @override
  int get day;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  @JsonKey(ignore: true)
  _$$StudyMeetingSchedulesModelImplCopyWith<_$StudyMeetingSchedulesModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
