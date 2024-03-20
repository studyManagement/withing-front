import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import '../../service/create/study_create_service.dart';
import '../../service/image/image_create_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class CreateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyCreateService _studyCreateService;
  final ImageCreateService _imageCreateService;

  CreateStudyViewModel(this._studyCreateService, this._imageCreateService);

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
  int? _studyId;
  int? get studyId => _studyId;
  final List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];
  File? _studyImageFile;

  @override
  bool get isStudyNameError => _isStudyNameError;

  @override
  bool get isStudyDescriptionError => _isStudyDescriptionError;

  @override
  String get studyImagePath => ''; // 사용 안 함

  @override
  bool isOldImageLoaded = true;

  bool get isStudyDiscloseToggled => _isStudyDiscloseToggled;

  /// check everything filled
  @override
  bool checkEverythingFilled() {
    if (_isStudyNameError &&
        _isStudyDescriptionError &&
        (!_isStudyDiscloseToggled || _studyDisclosePassword.length == 4) &&
        _studyMemberCount > 0) {
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
        break;
      case NewStudyType.studyDescription:
        _studyDescription = newValue;
        break;
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
    } else if (maxSelectedOptions == null ||
        _selectedCategories.length < maxSelectedOptions) {
      _selectedCategories.add(option);
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
  }

  /// update study member count
  @override
  set memberCount(int newValue) {
    if (newValue >= 0 && newValue <= 15) {
      _studyMemberCount = newValue;
      notifyListeners();
    }
  }

  /// update study image
  @override
  set studyImageFile(File? file) {
    _studyImageFile = file;
    notifyListeners();
  }

  /// call create image api
  @override
  Future<void> callImageApi() async {
    if (_studyImageFile != null) {
      _studyImageId =
      await _imageCreateService.callImageCreateApi(_studyImageFile!);
    }
    notifyListeners();
  }

  /// update study password
  set password(String newValue) {
    if (newValue.length == 4) {
      _studyDisclosePassword = newValue;
      notifyListeners();
    } else {
      _studyDisclosePassword = '';
      notifyListeners();
    }
  }

  /// create study api
  Future<void> createStudy() async {
      final StudyModel newStudy = await _studyCreateService.callCreateApi(
        _studyName,
        _studyMemberCount,
        (isStudyDiscloseToggled) ? 1 : 0,
        _studyDisclosePassword,
        _studyDescription,
        _selectedCategoryIndices..sort(),
        _studyImageId!,
      );
      _studyId = newStudy.id;
      notifyListeners();
  }
}
