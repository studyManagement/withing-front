// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_category_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StudyCategory _$StudyCategoryFromJson(Map<String, dynamic> json) {
  return _StudyCategory.fromJson(json);
}

/// @nodoc
mixin _$StudyCategory {
  int get studyId => throw _privateConstructorUsedError;
  String? get category1 => throw _privateConstructorUsedError;
  String? get category2 => throw _privateConstructorUsedError;
  String? get category3 => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StudyCategoryCopyWith<StudyCategory> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StudyCategoryCopyWith<$Res> {
  factory $StudyCategoryCopyWith(
          StudyCategory value, $Res Function(StudyCategory) then) =
      _$StudyCategoryCopyWithImpl<$Res, StudyCategory>;
  @useResult
  $Res call(
      {int studyId, String? category1, String? category2, String? category3});
}

/// @nodoc
class _$StudyCategoryCopyWithImpl<$Res, $Val extends StudyCategory>
    implements $StudyCategoryCopyWith<$Res> {
  _$StudyCategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? category1 = freezed,
    Object? category2 = freezed,
    Object? category3 = freezed,
  }) {
    return _then(_value.copyWith(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      category1: freezed == category1
          ? _value.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as String?,
      category2: freezed == category2
          ? _value.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as String?,
      category3: freezed == category3
          ? _value.category3
          : category3 // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StudyCategoryImplCopyWith<$Res>
    implements $StudyCategoryCopyWith<$Res> {
  factory _$$StudyCategoryImplCopyWith(
          _$StudyCategoryImpl value, $Res Function(_$StudyCategoryImpl) then) =
      __$$StudyCategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int studyId, String? category1, String? category2, String? category3});
}

/// @nodoc
class __$$StudyCategoryImplCopyWithImpl<$Res>
    extends _$StudyCategoryCopyWithImpl<$Res, _$StudyCategoryImpl>
    implements _$$StudyCategoryImplCopyWith<$Res> {
  __$$StudyCategoryImplCopyWithImpl(
      _$StudyCategoryImpl _value, $Res Function(_$StudyCategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studyId = null,
    Object? category1 = freezed,
    Object? category2 = freezed,
    Object? category3 = freezed,
  }) {
    return _then(_$StudyCategoryImpl(
      studyId: null == studyId
          ? _value.studyId
          : studyId // ignore: cast_nullable_to_non_nullable
              as int,
      category1: freezed == category1
          ? _value.category1
          : category1 // ignore: cast_nullable_to_non_nullable
              as String?,
      category2: freezed == category2
          ? _value.category2
          : category2 // ignore: cast_nullable_to_non_nullable
              as String?,
      category3: freezed == category3
          ? _value.category3
          : category3 // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StudyCategoryImpl implements _StudyCategory {
  const _$StudyCategoryImpl(
      {required this.studyId,
      required this.category1,
      required this.category2,
      required this.category3});

  factory _$StudyCategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StudyCategoryImplFromJson(json);

  @override
  final int studyId;
  @override
  final String? category1;
  @override
  final String? category2;
  @override
  final String? category3;

  @override
  String toString() {
    return 'StudyCategory(studyId: $studyId, category1: $category1, category2: $category2, category3: $category3)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StudyCategoryImpl &&
            (identical(other.studyId, studyId) || other.studyId == studyId) &&
            (identical(other.category1, category1) ||
                other.category1 == category1) &&
            (identical(other.category2, category2) ||
                other.category2 == category2) &&
            (identical(other.category3, category3) ||
                other.category3 == category3));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, studyId, category1, category2, category3);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StudyCategoryImplCopyWith<_$StudyCategoryImpl> get copyWith =>
      __$$StudyCategoryImplCopyWithImpl<_$StudyCategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StudyCategoryImplToJson(
      this,
    );
  }
}

abstract class _StudyCategory implements StudyCategory {
  const factory _StudyCategory(
      {required final int studyId,
      required final String? category1,
      required final String? category2,
      required final String? category3}) = _$StudyCategoryImpl;

  factory _StudyCategory.fromJson(Map<String, dynamic> json) =
      _$StudyCategoryImpl.fromJson;

  @override
  int get studyId;
  @override
  String? get category1;
  @override
  String? get category2;
  @override
  String? get category3;
  @override
  @JsonKey(ignore: true)
  _$$StudyCategoryImplCopyWith<_$StudyCategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
