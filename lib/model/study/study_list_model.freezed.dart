// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_list_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyListModel _$StudyListModelFromJson(Map<String, dynamic> json) {
  return _StudyListModel.fromJson(json);
}

/// @nodoc
mixin _$StudyListModel {
  int get id => throw _privateConstructorUsedError;
  String get studyName => throw _privateConstructorUsedError;
  int get max => throw _privateConstructorUsedError;
  int get headcount => throw _privateConstructorUsedError;
  bool get private => throw _privateConstructorUsedError;
  String? get studyImage => throw _privateConstructorUsedError;
  String get explanation => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  List<String> get categories => throw _privateConstructorUsedError;
  List<StudyMeetingSchedulesModel> get meetingSchedules =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyListModelCopyWith<StudyListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyListModelCopyWith<$Res> {
  factory $StudyListModelCopyWith(
          StudyListModel value, $Res Function(StudyListModel) then) =
      _$StudyListModelCopyWithImpl<$Res, StudyListModel>;
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      bool private,
      String? studyImage,
      String explanation,
      DateTime createdAt,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules});
}

/// @nodoc
class _$StudyListModelCopyWithImpl<$Res, $Val extends StudyListModel>
    implements $StudyListModelCopyWith<$Res> {
  _$StudyListModelCopyWithImpl(this._value, this._then);

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
    Object? studyImage = freezed,
    Object? explanation = null,
    Object? createdAt = null,
    Object? categories = null,
    Object? meetingSchedules = null,
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
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value.meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyListModelImplCopyWith<$Res>
    implements $StudyListModelCopyWith<$Res> {
  factory _$$StudyListModelImplCopyWith(_$StudyListModelImpl value,
          $Res Function(_$StudyListModelImpl) then) =
      __$$StudyListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String studyName,
      int max,
      int headcount,
      bool private,
      String? studyImage,
      String explanation,
      DateTime createdAt,
      List<String> categories,
      List<StudyMeetingSchedulesModel> meetingSchedules});
}

/// @nodoc
class __$$StudyListModelImplCopyWithImpl<$Res>
    extends _$StudyListModelCopyWithImpl<$Res, _$StudyListModelImpl>
    implements _$$StudyListModelImplCopyWith<$Res> {
  __$$StudyListModelImplCopyWithImpl(
      _$StudyListModelImpl _value, $Res Function(_$StudyListModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? studyName = null,
    Object? max = null,
    Object? headcount = null,
    Object? private = null,
    Object? studyImage = freezed,
    Object? explanation = null,
    Object? createdAt = null,
    Object? categories = null,
    Object? meetingSchedules = null,
  }) {
    return _then(_$StudyListModelImpl(
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
      studyImage: freezed == studyImage
          ? _value.studyImage
          : studyImage // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: null == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<String>,
      meetingSchedules: null == meetingSchedules
          ? _value._meetingSchedules
          : meetingSchedules // ignore: cast_nullable_to_non_nullable
              as List<StudyMeetingSchedulesModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyListModelImpl implements _StudyListModel {
  const _$StudyListModelImpl(
      {required this.id,
      required this.studyName,
      required this.max,
      required this.headcount,
      required this.private,
      required this.studyImage,
      required this.explanation,
      required this.createdAt,
      required final List<String> categories,
      required final List<StudyMeetingSchedulesModel> meetingSchedules})
      : _categories = categories,
        _meetingSchedules = meetingSchedules;

  factory _$StudyListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyListModelImplFromJson(json);

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
  final String? studyImage;
  @override
  final String explanation;
  @override
  final DateTime createdAt;
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
  String toString() {
    return 'StudyListModel(id: $id, studyName: $studyName, max: $max, headcount: $headcount, private: $private, studyImage: $studyImage, explanation: $explanation, createdAt: $createdAt, categories: $categories, meetingSchedules: $meetingSchedules)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyListModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.studyName, studyName) ||
                other.studyName == studyName) &&
            (identical(other.max, max) || other.max == max) &&
            (identical(other.headcount, headcount) ||
                other.headcount == headcount) &&
            (identical(other.private, private) || other.private == private) &&
            (identical(other.studyImage, studyImage) ||
                other.studyImage == studyImage) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._meetingSchedules, _meetingSchedules));
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
      studyImage,
      explanation,
      createdAt,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_meetingSchedules));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyListModelImplCopyWith<_$StudyListModelImpl> get copyWith =>
      __$$StudyListModelImplCopyWithImpl<_$StudyListModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyListModelImplToJson(
      this,
    );
  }
}

abstract class _StudyListModel implements StudyListModel {
  const factory _StudyListModel(
          {required final int id,
          required final String studyName,
          required final int max,
          required final int headcount,
          required final bool private,
          required final String? studyImage,
          required final String explanation,
          required final DateTime createdAt,
          required final List<String> categories,
          required final List<StudyMeetingSchedulesModel> meetingSchedules}) =
      _$StudyListModelImpl;

  factory _StudyListModel.fromJson(Map<String, dynamic> json) =
      _$StudyListModelImpl.fromJson;

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
  String? get studyImage;
  @override
  String get explanation;
  @override
  DateTime get createdAt;
  @override
  List<String> get categories;
  @override
  List<StudyMeetingSchedulesModel> get meetingSchedules;
  @override
  @JsonKey(ignore: true)
  _$$StudyListModelImplCopyWith<_$StudyListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
