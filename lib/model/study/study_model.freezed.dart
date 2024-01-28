// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyModel _$StudyModelFromJson(Map<String, dynamic> json) {
  return _StudyModel.fromJson(json);
}

/// @nodoc
mixin _$StudyModel {
  int get id => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  int get headcount => throw _privateConstructorUsedError;
  bool get private => throw _privateConstructorUsedError;
  bool get finished => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  int get leaderId => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get deadline => throw _privateConstructorUsedError;
  String get studyImage => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<StudyMeetingSchedulesModel> get meetingSchedules =>
      throw _privateConstructorUsedError;
  List<UserModel> get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyModelCopyWith<StudyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyModelCopyWith<$Res> {
  factory $StudyModelCopyWith(
          StudyModel value, $Res Function(StudyModel) then) =
      _$StudyModelCopyWithImpl<$Res, StudyModel>;
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      bool private,
      bool finished,
      String explanation,
      int leaderId,
      DateTime createdAt,
      DateTime deadline,
      String studyImage,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules,
      List<UserModel> users});
}

/// @nodoc
class _$StudyModelCopyWithImpl<$Res, $Val extends StudyModel>
    implements $StudyModelCopyWith<$Res> {
  _$StudyModelCopyWithImpl(this._value, this._then);

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
    Object? private = null,
    Object? finished = null,
    Object? explanation = null,
    Object? leaderId = null,
    Object? createdAt = null,
    Object? deadline = null,
    Object? studyImage = null,
    Object? categories = null,
    Object? meetingSchedules = null,
    Object? users = null,
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
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      studyImage: null == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value.meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyModelImplCopyWith<$Res>
    implements $StudyModelCopyWith<$Res> {
  factory _$$StudyModelImplCopyWith(
          _$StudyModelImpl value, $Res Function(_$StudyModelImpl) then) =
      __$$StudyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      bool private,
      bool finished,
      String explanation,
      int leaderId,
      DateTime createdAt,
      DateTime deadline,
      String studyImage,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules,
      List<UserModel> users});
}

/// @nodoc
class __$$StudyModelImplCopyWithImpl<$Res>
    extends _$StudyModelCopyWithImpl<$Res, _$StudyModelImpl>
    implements _$$StudyModelImplCopyWith<$Res> {
  __$$StudyModelImplCopyWithImpl(
      _$StudyModelImpl _value, $Res Function(_$StudyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyName = null,
    Object? max = null,
    Object? headcount = null,
    Object? private = null,
    Object? finished = null,
    Object? explanation = null,
    Object? leaderId = null,
    Object? createdAt = null,
    Object? deadline = null,
    Object? studyImage = null,
    Object? categories = null,
    Object? meetingSchedules = null,
    Object? users = null,
  }) {
    return _then(_$StudyModelImpl(
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
      private: null == private
          ? _value.private
          : private // ignore: cast_nullable_to_non_nullable
              as bool,
      finished: null == finished
          ? _value.finished
          : finished // ignore: cast_nullable_to_non_nullable
              as bool,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      leaderId: null == leaderId
          ? _value.leaderId
          : leaderId // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deadline: null == deadline
          ? _value.deadline
          : deadline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      studyImage: null == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value._meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<UserModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyModelImpl implements _StudyModel {
  const _$StudyModelImpl(
      {required this.id,
      required this.studyName,
      required this.max,
      required this.headcount,
      required this.private,
      required this.finished,
      required this.explanation,
      required this.leaderId,
      required this.createdAt,
      required this.deadline,
      required this.studyImage,
      required final List<String> categories,
      required final List<StudyMeetingSchedulesModel> meetingSchedules,
      required final List<UserModel> users})
      : _categories = categories,
        _meetingSchedules = meetingSchedules,
        _users = users;

  factory _$StudyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyModelImplFromJson(json);

  @override
  final int id;
  @override
  final String studyName;
  @override
  final int max;
  @override
  final int headcount;
  @override
  final bool private;
  @override
  final bool finished;
  @override
  final String explanation;
  @override
  final int leaderId;
  @override
  final DateTime createdAt;
  @override
  final DateTime deadline;
  @override
  final String studyImage;
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

  final List<UserModel> _users;
  @override
  List<UserModel> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'StudyModel(id: $id, studyName: $studyName, max: $max, headcount: $headcount, private: $private, finished: $finished, explanation: $explanation, leaderId: $leaderId, createdAt: $createdAt, deadline: $deadline, studyImage: $studyImage, categories: $categories, meetingSchedules: $meetingSchedules, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headcount, headcount) ||
                other.headcount == headcount) &&
            (identical(other.private, private) || other.private == private) &&
            (identical(other.finished, finished) ||
                other.finished == finished) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.leaderId, leaderId) ||
                other.leaderId == leaderId) &&
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
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      studyName,
      max,
      headcount,
      private,
      finished,
      explanation,
      leaderId,
      createdAt,
      deadline,
      studyImage,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_meetingSchedules),
      const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyModelImplCopyWith<_$StudyModelImpl> get copyWith =>
      __$$StudyModelImplCopyWithImpl<_$StudyModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyModelImplToJson(
      this,
    );
  }
}

abstract class _StudyModel implements StudyModel {
  const factory _StudyModel(
      {required final int id,
      required final String studyName,
      required final int max,
      required final int headcount,
      required final bool private,
      required final bool finished,
      required final String explanation,
      required final int leaderId,
      required final DateTime createdAt,
      required final DateTime deadline,
      required final String studyImage,
      required final List<String> categories,
      required final List<StudyMeetingSchedulesModel> meetingSchedules,
      required final List<UserModel> users}) = _$StudyModelImpl;

  factory _StudyModel.fromJson(Map<String, dynamic> json) =
      _$StudyModelImpl.fromJson;

  @override
  int get id;
  @override
  String get studyName;
  @override
  int get max;
  @override
  int get headcount;
  @override
  bool get private;
  @override
  bool get finished;
  @override
  String get explanation;
  @override
  int get leaderId;
  @override
  DateTime get createdAt;
  @override
  DateTime get deadline;
  @override
  String get studyImage;
  @override
  List<String> get categories;
  @override
  List<StudyMeetingSchedulesModel> get meetingSchedules;
  @override
  List<UserModel> get users;
  @override
  @JsonKey(ignore: true)
  _$$StudyModelImplCopyWith<_$StudyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
