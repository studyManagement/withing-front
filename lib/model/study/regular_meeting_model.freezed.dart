// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'regular_meeting_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RegularMeetingModel _$RegularMeetingModelFromJson(Map<String, dynamic> json) {
  return _RegularMeetingModel.fromJson(json);
}

/// @nodoc
mixin _$RegularMeetingModel {
  int get regularMeetingId => throw _privateConstructorUsedError;
  int get gap => throw _privateConstructorUsedError;
  int get day1 => throw _privateConstructorUsedError;
  int get day2 => throw _privateConstructorUsedError;
  int get day3 => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RegularMeetingModelCopyWith<RegularMeetingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegularMeetingModelCopyWith<$Res> {
  factory $RegularMeetingModelCopyWith(
          RegularMeetingModel value, $Res Function(RegularMeetingModel) then) =
      _$RegularMeetingModelCopyWithImpl<$Res, RegularMeetingModel>;
  @useResult
  $Res call(
      {int regularMeetingId,
      int gap,
      int day1,
      int day2,
      int day3,
      String startTime,
      String endTime});
}

/// @nodoc
class _$RegularMeetingModelCopyWithImpl<$Res, $Val extends RegularMeetingModel>
    implements $RegularMeetingModelCopyWith<$Res> {
  _$RegularMeetingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regularMeetingId = null,
    Object? gap = null,
    Object? day1 = null,
    Object? day2 = null,
    Object? day3 = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_value.copyWith(
      regularMeetingId: null == regularMeetingId
          ? _value.regularMeetingId
          : regularMeetingId // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      day1: null == day1
          ? _value.day1
          : day1 // ignore: cast_nullable_to_non_nullable
              as int,
      day2: null == day2
          ? _value.day2
          : day2 // ignore: cast_nullable_to_non_nullable
              as int,
      day3: null == day3
          ? _value.day3
          : day3 // ignore: cast_nullable_to_non_nullable
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
abstract class _$$RegularMeetingModelImplCopyWith<$Res>
    implements $RegularMeetingModelCopyWith<$Res> {
  factory _$$RegularMeetingModelImplCopyWith(_$RegularMeetingModelImpl value,
          $Res Function(_$RegularMeetingModelImpl) then) =
      __$$RegularMeetingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int regularMeetingId,
      int gap,
      int day1,
      int day2,
      int day3,
      String startTime,
      String endTime});
}

/// @nodoc
class __$$RegularMeetingModelImplCopyWithImpl<$Res>
    extends _$RegularMeetingModelCopyWithImpl<$Res, _$RegularMeetingModelImpl>
    implements _$$RegularMeetingModelImplCopyWith<$Res> {
  __$$RegularMeetingModelImplCopyWithImpl(_$RegularMeetingModelImpl _value,
      $Res Function(_$RegularMeetingModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? regularMeetingId = null,
    Object? gap = null,
    Object? day1 = null,
    Object? day2 = null,
    Object? day3 = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$RegularMeetingModelImpl(
      regularMeetingId: null == regularMeetingId
          ? _value.regularMeetingId
          : regularMeetingId // ignore: cast_nullable_to_non_nullable
              as int,
      gap: null == gap
          ? _value.gap
          : gap // ignore: cast_nullable_to_non_nullable
              as int,
      day1: null == day1
          ? _value.day1
          : day1 // ignore: cast_nullable_to_non_nullable
              as int,
      day2: null == day2
          ? _value.day2
          : day2 // ignore: cast_nullable_to_non_nullable
              as int,
      day3: null == day3
          ? _value.day3
          : day3 // ignore: cast_nullable_to_non_nullable
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
class _$RegularMeetingModelImpl implements _RegularMeetingModel {
  const _$RegularMeetingModelImpl(
      {required this.regularMeetingId,
      required this.gap,
      required this.day1,
      required this.day2,
      required this.day3,
      required this.startTime,
      required this.endTime});

  factory _$RegularMeetingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RegularMeetingModelImplFromJson(json);

  @override
  final int regularMeetingId;
  @override
  final int gap;
  @override
  final int day1;
  @override
  final int day2;
  @override
  final int day3;
  @override
  final String startTime;
  @override
  final String endTime;

  @override
  String toString() {
    return 'RegularMeetingModel(regularMeetingId: $regularMeetingId, gap: $gap, day1: $day1, day2: $day2, day3: $day3, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RegularMeetingModelImpl &&
            (identical(other.regularMeetingId, regularMeetingId) ||
                other.regularMeetingId == regularMeetingId) &&
            (identical(other.gap, gap) || other.gap == gap) &&
            (identical(other.day1, day1) || other.day1 == day1) &&
            (identical(other.day2, day2) || other.day2 == day2) &&
            (identical(other.day3, day3) || other.day3 == day3) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, regularMeetingId, gap, day1, day2, day3, startTime, endTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RegularMeetingModelImplCopyWith<_$RegularMeetingModelImpl> get copyWith =>
      __$$RegularMeetingModelImplCopyWithImpl<_$RegularMeetingModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RegularMeetingModelImplToJson(
      this,
    );
  }
}

abstract class _RegularMeetingModel implements RegularMeetingModel {
  const factory _RegularMeetingModel(
      {required final int regularMeetingId,
      required final int gap,
      required final int day1,
      required final int day2,
      required final int day3,
      required final String startTime,
      required final String endTime}) = _$RegularMeetingModelImpl;

  factory _RegularMeetingModel.fromJson(Map<String, dynamic> json) =
      _$RegularMeetingModelImpl.fromJson;

  @override
  int get regularMeetingId;
  @override
  int get gap;
  @override
  int get day1;
  @override
  int get day2;
  @override
  int get day3;
  @override
  String get startTime;
  @override
  String get endTime;
  @override
  @JsonKey(ignore: true)
  _$$RegularMeetingModelImplCopyWith<_$RegularMeetingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
