import 'dart:io';

import 'package:flutter/material.dart';

import '../../service/create/study_create_service.dart';
import '../../service/image/study_image_create_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class CreateStudyViewModel with ChangeNotifier {
  final StudyCreateService _studyCreateService;
  final StudyImageCreateService _studyImageCreateService;

  CreateStudyViewModel(this._studyCreateService, this._studyImageCreateService);

  bool _isStudyNameError = false;
  bool _isStudyDescriptionError = false;
  bool _isStudyDiscloseToggled = false;
  String _studyName = '';
  String _studyDescription = '';
  String _studyDisclosePassword = '';
  int _studyMemberCount = 0;
  int? _studyImageId;
  List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndicies = [];
  File? _studyImageFile;

  bool get isStudyNameError => _isStudyNameError;
  bool get isStudyDescriptionError => _isStudyDescriptionError;
  bool get isStudyDiscloseToggled => _isStudyDiscloseToggled;
  List<String> get selectedCategories => _selectedCategories;
  File? get studyImage => _studyImageFile;

  /// check everything filled
  bool checkEverythingFilled() {
    if (_isStudyNameError &&
        _isStudyDescriptionError &&
        (!_isStudyDiscloseToggled || _studyDisclosePassword.length == 4) &&
        _studyMemberCount > 0 &&
        _selectedCategories.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /// text input validation : study name & description
  void checkStudyNameAndDescription(NewStudyType type, String input) {
    switch (type) {
      case NewStudyType.studyName:
        _isStudyNameError =
            _validateInput(NewStudyType.studyName, input, r'^.{2,20}$');
        break;
      case NewStudyType.studyDescription:
        _isStudyDescriptionError =
            _validateInput(NewStudyType.studyDescription, input, r'^.{1,65}$');
        break;
    }
    notifyListeners();
  }

  /// update study name and description
  void updateStudyNameAndDescription(NewStudyType type, String newValue) {
    switch (type) {
      case NewStudyType.studyName:
        _studyName = newValue;
        // debugPrint(_studyName);
        break;
      case NewStudyType.studyDescription:
        _studyDescription = newValue;
        break;
      // debugPrint(_studyDescription);
    }
  }

  /// RegExp pattern-matching
  bool _validateInput(NewStudyType type, String input, String pattern) {
    final isValid = RegExp(pattern).hasMatch(input);
    switch (isValid) {
      case true:
        updateStudyNameAndDescription(type, input);
        return true;
      default: // false
        return false;
    }
  }

  /// update disclose toggle
  void toggle() {
    _isStudyDiscloseToggled = !_isStudyDiscloseToggled;
    notifyListeners();
  }

  /// update selected categories
  void updateSelectedCategories(String option, int? maxSelectedOptions) {
    if (_selectedCategories.contains(option)) {
      _selectedCategories.remove(option);
      debugPrint('$option 제거');
    } else if (maxSelectedOptions == null ||
        _selectedCategories.length < maxSelectedOptions) {
      _selectedCategories.add(option);
      debugPrint('$option 추가');
    }
    updateSelectedCategoryIndicies();
    notifyListeners();
  }

  /// update selected category indicies
  void updateSelectedCategoryIndicies() {
    _selectedCategoryIndicies = _selectedCategories
        .map((category) => getStudyCategories().indexOf(category))
        .toList();
    print(_selectedCategories);
    print(_selectedCategoryIndicies);
  }

  /// update study member count
  set memberCount(int newValue) {
    if (newValue >= 0 && newValue <= 15) {
      _studyMemberCount = newValue;
      debugPrint('스터디 인원: $_studyMemberCount');
      notifyListeners();
    }
  }

  /// update study password
  set password(String newValue) {
    if (newValue.length == 4) {
      _studyDisclosePassword = newValue;
      debugPrint('패스워드: $_studyDisclosePassword');
      notifyListeners();
    } else {
      _studyDisclosePassword = '';
      debugPrint('패스워드 입력 중...');
      notifyListeners();
    }
  }

  /// update study image
  set studyImage(File? file) {
    _studyImageFile = file;
    debugPrint('스터디 이미지 업데이트');
    notifyListeners();
  }

  /// update study image id
  set studyId(int id) {
    _studyImageId = id;
    debugPrint('스터디 이미지 id 업데이트');
    notifyListeners();
  }

  /// create image api
  Future<void> createImage() async {
    if (_studyImageFile != null) {
      _studyImageId =
          await _studyImageCreateService.callCreateApi(_studyImageFile!);
      print(_studyImageId);
    }
    notifyListeners();
  }

  /// create study api
  Future<void> createStudy() async {
    await createImage();

    await _studyCreateService.callCreateApi(
      _studyName,
      _studyMemberCount,
      (isStudyDiscloseToggled) ? 1 : 0,
      _studyDisclosePassword,
      _studyDescription,
      0, // leaderId?
      _selectedCategoryIndicies..sort(),
      _studyImageId,
    );
    notifyListeners();
  }
}

///
/// Utils - new study

String getNewStudyTitle() {
  return '스터디 생성하기';
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

String getErrorText(NewStudyType type, bool isValidation) {
  if (type == NewStudyType.studyName) {
    return isValidation ? '멋진 이름이네요!' : '2 ~ 20자 사이의 이름을 설정해주세요.';
  } else if (type == NewStudyType.studyDescription) {
    return isValidation ? '멋진 설명이네요!' : '';
  } else {
    return '유효하지 않은 입력입니다.';
  }
}

List<String> convertIndiciesToElements(List<int> indicies) {
  return indicies.map((index) => getStudyCategories()[index]).toList();
}
