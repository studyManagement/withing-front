import 'dart:io';
import '../../views/create/widgets/study_text_field.dart';

enum StudyPageType { create, update }

abstract class StudyInfoViewModel {
  // create or update study
  String get studyName;

  String get studyDescription;

  List<String> get selectedCategories;

  List<int> get selectedCategoryIndices;

  int get studyMemberCount;

  File? get studyImageFile;

  String get studyImagePath;

  bool get isStudyNameError;

  bool get isStudyDescriptionError;

  bool get isOldImage;

  String get studyImageUuid;

  void checkStudyNameAndDescription(NewStudyType type, String input);

  void updateStudyNameAndDescription(NewStudyType type, String input);

  void updateSelectedCategories(String option, int? maxSelectedOptions);

  void updateSelectedCategoryIndices();

  Future<void> callImageApi();

  bool checkEverythingFilled();

  set studyImageFile(File? file);

  set memberCount(int value);

  set studyImagePath(String value);

  set isOldImage(bool value);

  set studyImageUuid(String value);

  /// RegExp pattern-matching
  bool validateInput(NewStudyType type, String input, String pattern) {
    final isValid = RegExp(pattern).hasMatch(input);
    switch (isValid) {
      case true:
        updateStudyNameAndDescription(type, input);
        return true;
      default: // false
        return false;
    }
  }
}

/// Utils - new study

String getNewStudyTitle({isCreate}) {
  if (isCreate) {
    return '스터디 생성하기';
  } else {
    return '스터디 정보 수정';
  }
}

List<String> getStudyCategories() {
  return const ['어학', '자격증', '취업', '시험', '취미', '프로그래밍', '기타'];
}

String getStudyTitle(NewStudyType type) {
  switch (type) {
    case NewStudyType.studyName:
      return '스터디 이름';
    case NewStudyType.studyDescription:
      return '스터디 설명';
    default:
      return '유효하지 않은 타입입니다.';
  }
}

String getHintText(NewStudyType type) {
  switch (type) {
    case NewStudyType.studyName:
      return '스터디 이름을 입력해주세요.';
    case NewStudyType.studyDescription:
      return '스터디를 소개할 수 있는 설명을 추가해보세요.';
    default:
      return '유효하지 않은 타입입니다.';
  }
}

String getErrorText(NewStudyType type, bool isValidation, bool isCreate) {
  if(isCreate) {
    if (type == NewStudyType.studyName) {
      return isValidation ? '멋진 이름이네요!' : '2 ~ 20자 사이의 이름을 설정해주세요.';
    } else if (type == NewStudyType.studyDescription) {
      return isValidation ? '멋진 설명이네요!' : '';
    } else {
      return '유효하지 않은 입력입니다.';
    }
  }
  else {
    return '';
  }
}

List<String> convertIndicesToElements(List<int> indicies) {
  return indicies.map((index) => getStudyCategories()[index]).toList();
}

