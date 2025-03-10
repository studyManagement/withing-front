// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'searched_study_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SearchedStudyInfo _$SearchedStudyInfoFromJson(Map<String, dynamic> json) {
  return _SearchedStudyInfo.fromJson(json);
}

/// @nodoc
mixin _$SearchedStudyInfo {
  int get id => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  int get headcount => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  String? get deadline => throw _privateConstructorUsedError;
  String? get studyImage => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<StudyMeetingSchedulesModel> get meetingSchedules =>
      throw _privateConstructorUsedError;
  bool get private => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchedStudyInfoCopyWith<SearchedStudyInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchedStudyInfoCopyWith<$Res> {
  factory $SearchedStudyInfoCopyWith(
          SearchedStudyInfo value, $Res Function(SearchedStudyInfo) then) =
      _$SearchedStudyInfoCopyWithImpl<$Res, SearchedStudyInfo>;
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      String explanation,
      String createdAt,
      String? deadline,
      String? studyImage,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules,
      bool private});
}

/// @nodoc
class _$SearchedStudyInfoCopyWithImpl<$Res, $Val extends SearchedStudyInfo>
    implements $SearchedStudyInfoCopyWith<$Res> {
  _$SearchedStudyInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyName = null,
    Object? max = null,
    Object? headcount = null,
    Object? explanation = null,
    Object? createdAt = null,
    Object? deadline = freezed,
    Object? studyImage = freezed,
    Object? categories = null,
    Object? meetingSchedules = null,
    Object? private = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      headcount: null == headcount
          ? _value.headcount
          : headcount // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value.meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchedStudyInfoImplCopyWith<$Res>
    implements $SearchedStudyInfoCopyWith<$Res> {
  factory _$$SearchedStudyInfoImplCopyWith(_$SearchedStudyInfoImpl value,
          $Res Function(_$SearchedStudyInfoImpl) then) =
      __$$SearchedStudyInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      String explanation,
      String createdAt,
      String? deadline,
      String? studyImage,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules,
      bool private});
}

/// @nodoc
class __$$SearchedStudyInfoImplCopyWithImpl<$Res>
    extends _$SearchedStudyInfoCopyWithImpl<$Res, _$SearchedStudyInfoImpl>
    implements _$$SearchedStudyInfoImplCopyWith<$Res> {
  __$$SearchedStudyInfoImplCopyWithImpl(_$SearchedStudyInfoImpl _value,
      $Res Function(_$SearchedStudyInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyName = null,
    Object? max = null,
    Object? headcount = null,
    Object? explanation = null,
    Object? createdAt = null,
    Object? deadline = freezed,
    Object? studyImage = freezed,
    Object? categories = null,
    Object? meetingSchedules = null,
    Object? private = null,
  }) {
    return _then(_$SearchedStudyInfoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      studyName: null == studyName
          ? _value.studyName
          : studyName // ignore: cast_nullable_to_non_nullable
              as String,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as int,
      headcount: null == headcount
          ? _value.headcount
          : headcount // ignore: cast_nullable_to_non_nullable
              as int,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      deadline: freezed == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as String?,
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value._meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchedStudyInfoImpl implements _SearchedStudyInfo {
  const _$SearchedStudyInfoImpl(
      {required this.id,
      required this.studyName,
      required this.max,
      required this.headcount,
      required this.explanation,
      required this.createdAt,
      required this.deadline,
      required this.studyImage,
      required final List<String> categories,
      required final List<StudyMeetingSchedulesModel> meetingSchedules,
      required this.private})
      : _categories = categories,
        _meetingSchedules = meetingSchedules;

  factory _$SearchedStudyInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchedStudyInfoImplFromJson(json);

  @override
  final int id;
  @override
  final String studyName;
  @override
  final int max;
  @override
  final int headcount;
  @override
  final String explanation;
  @override
  final String createdAt;
  @override
  final String? deadline;
  @override
  final String? studyImage;
  final List<String> _categories;
  @override
  List<String> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<StudyMeetingSchedulesModel> _meetingSchedules;
  @override
  List<StudyMeetingSchedulesModel> get meetingSchedules {
    if (_meetingSchedules is EqualUnmodifiableListView)
      return _meetingSchedules;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meetingSchedules);
  }

  @override
  final bool private;

  @override
  String toString() {
    return 'SearchedStudyInfo(id: $id, studyName: $studyName, max: $max, headcount: $headcount, explanation: $explanation, createdAt: $createdAt, deadline: $deadline, studyImage: $studyImage, categories: $categories, meetingSchedules: $meetingSchedules, private: $private)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchedStudyInfoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headcount, headcount) ||
                other.headcount == headcount) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.studyImage, studyImage) ||
                other.studyImage == studyImage) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._meetingSchedules, _meetingSchedules) &&
            (identical(other.private, private) || other.private == private));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studyName,
      max,
      headcount,
      explanation,
      createdAt,
      deadline,
      studyImage,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_meetingSchedules),
      private);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchedStudyInfoImplCopyWith<_$SearchedStudyInfoImpl> get copyWith =>
      __$$SearchedStudyInfoImplCopyWithImpl<_$SearchedStudyInfoImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchedStudyInfoImplToJson(
      this,
    );
  }
}

abstract class _SearchedStudyInfo implements SearchedStudyInfo {
  const factory _SearchedStudyInfo(
      {required final int id,
      required final String studyName,
      required final int max,
      required final int headcount,
      required final String explanation,
      required final String createdAt,
      required final String? deadline,
      required final String? studyImage,
      required final List<String> categories,
      required final List<StudyMeetingSchedulesModel> meetingSchedules,
      required final bool private}) = _$SearchedStudyInfoImpl;

  factory _SearchedStudyInfo.fromJson(Map<String, dynamic> json) =
      _$SearchedStudyInfoImpl.fromJson;

  @override
  int get id;
  @override
  String get studyName;
  @override
  int get max;
  @override
  int get headcount;
  @override
  String get explanation;
  @override
  String get createdAt;
  @override
  String? get deadline;
  @override
  String? get studyImage;
  @override
  List<String> get categories;
  @override
  List<StudyMeetingSchedulesModel> get meetingSchedules;
  @override
  bool get private;
  @override
  @JsonKey(ignore: true)
  _$$SearchedStudyInfoImplCopyWith<_$SearchedStudyInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MeetingInfo _$MeetingInfoFromJson(Map<String, dynamic> json) {
  return _MeetingInfo.fromJson(json);
}

/// @nodoc
mixin _$MeetingInfo {
  int get id => throw _privateConstructorUsedError;
  int get day => throw _privateConstructorUsedError;
  String get startTime => throw _privateConstructorUsedError;
  String get endTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MeetingInfoCopyWith<MeetingInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MeetingInfoCopyWith<$Res> {
  factory $MeetingInfoCopyWith(
          MeetingInfo value, $Res Function(MeetingInfo) then) =
      _$MeetingInfoCopyWithImpl<$Res, MeetingInfo>;
  @useResult
  $Res call({int id, int day, String startTime, String endTime});
}

/// @nodoc
class _$MeetingInfoCopyWithImpl<$Res, $Val extends MeetingInfo>
    implements $MeetingInfoCopyWith<$Res> {
  _$MeetingInfoCopyWithImpl(this._value, this._then);

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
abstract class _$$MeetingInfoImplCopyWith<$Res>
    implements $MeetingInfoCopyWith<$Res> {
  factory _$$MeetingInfoImplCopyWith(
          _$MeetingInfoImpl value, $Res Function(_$MeetingInfoImpl) then) =
      __$$MeetingInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, int day, String startTime, String endTime});
}

/// @nodoc
class __$$MeetingInfoImplCopyWithImpl<$Res>
    extends _$MeetingInfoCopyWithImpl<$Res, _$MeetingInfoImpl>
    implements _$$MeetingInfoImplCopyWith<$Res> {
  __$$MeetingInfoImplCopyWithImpl(
      _$MeetingInfoImpl _value, $Res Function(_$MeetingInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? day = null,
    Object? startTime = null,
    Object? endTime = null,
  }) {
    return _then(_$MeetingInfoImpl(
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
class _$MeetingInfoImpl implements _MeetingInfo {
  const _$MeetingInfoImpl(
      {required this.id,
      required this.day,
      required this.startTime,
      required this.endTime});

  factory _$MeetingInfoImpl.fromJson(Map<String, dynamic> json) =>
      _$$MeetingInfoImplFromJson(json);

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
    return 'MeetingInfo(id: $id, day: $day, startTime: $startTime, endTime: $endTime)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MeetingInfoImpl &&
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
  _$$MeetingInfoImplCopyWith<_$MeetingInfoImpl> get copyWith =>
      __$$MeetingInfoImplCopyWithImpl<_$MeetingInfoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MeetingInfoImplToJson(
      this,
    );
  }
}

abstract class _MeetingInfo implements MeetingInfo {
  const factory _MeetingInfo(
      {required final int id,
      required final int day,
      required final String startTime,
      required final String endTime}) = _$MeetingInfoImpl;

  factory _MeetingInfo.fromJson(Map<String, dynamic> json) =
      _$MeetingInfoImpl.fromJson;

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
  _$$MeetingInfoImplCopyWith<_$MeetingInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
