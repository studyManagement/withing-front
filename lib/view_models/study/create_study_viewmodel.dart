import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/view_models/study/study_info_viewmodels.dart';

import '../../service/create/study_create_service.dart';
import '../../service/image/study_image_create_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class CreateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyCreateService _studyCreateService;
  final StudyImageCreateService _studyImageCreateService;

  CreateStudyViewModel(this._studyCreateService, this._studyImageCreateService);

  @override
  String get studyDescription => _studyDescription;
  @override
  String get studyName => _studyName;
  @override
  List<String> get selectedCategories => _selectedCategories;
  @override
  List<int> get selectedCategoryIndices => _selectedCategoryIndices;
  @override
  int get studyMemberCount => _studyMemberCount;
  @override
  File? get studyImageFile => _studyImageFile;


  bool _isStudyNameError = false;
  bool _isStudyDescriptionError = false;
  bool _isStudyDiscloseToggled = false;
  String _studyName = '';
  String _studyDescription = '';
  String _studyDisclosePassword = '';
  int _studyMemberCount = 0;
  int? _studyImageId;
  List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];
  File? _studyImageFile;

  @override
  bool get isStudyNameError => _isStudyNameError;
  @override
  bool get isStudyDescriptionError => _isStudyDescriptionError;
  @override
  String get studyImagePath => ''; // 사용 안 함

  bool get isStudyDiscloseToggled => _isStudyDiscloseToggled;

  // List<String> get selectedCategories => _selectedCategories;
  // File? get studyImage => _studyImageFile;

  /// check everything filled
  @override
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
  @override
  void checkStudyNameAndDescription(NewStudyType type, String input) {
    switch (type) {
      case NewStudyType.studyName:
        _isStudyNameError =
            validateInput(NewStudyType.studyName, input, r'^.{2,20}$');
        break;
      case NewStudyType.studyDescription:
        _isStudyDescriptionError =
            validateInput(NewStudyType.studyDescription, input, r'^.{1,65}$');
        break;
    }
    notifyListeners();
  }

  /// update study name and description
  @override
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

  /// update disclose toggle
  void toggle() {
    _isStudyDiscloseToggled = !_isStudyDiscloseToggled;
    notifyListeners();
  }

  /// update selected categories
  @override
  void updateSelectedCategories(String option, int? maxSelectedOptions) {
    if (_selectedCategories.contains(option)) {
      _selectedCategories.remove(option);
      debugPrint('$option 제거');
    } else if (maxSelectedOptions == null ||
        _selectedCategories.length < maxSelectedOptions) {
      _selectedCategories.add(option);
      debugPrint('$option 추가');
    }
    updateSelectedCategoryIndices();
    notifyListeners();
  }

  /// update selected category indicies
  @override
  void updateSelectedCategoryIndices() {
    _selectedCategoryIndices = _selectedCategories
        .map((category) => getStudyCategories().indexOf(category))
        .toList();
    print(_selectedCategories);
    print(_selectedCategoryIndices);
  }

  /// update study member count
  @override
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
  @override
  set studyImageFile(File? file) {
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
      Authentication.instance.userId,
      _selectedCategoryIndices..sort(),
      _studyImageId,
    );
    notifyListeners();
  }

  @override
  bool isOldImageLoaded = true;

}
