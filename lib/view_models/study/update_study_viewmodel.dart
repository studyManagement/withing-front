import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/view_models/study/model/updated_study_info.dart';
import 'package:modi/view_models/study/study_info_viewmodels.dart';
import '../../service/image/study_image_update_service.dart';
import '../../service/study/study_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class UpdateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyService _studyService;
  final StudyImageUpdateService _studyImageUpdateService;

  UpdateStudyViewModel(this._studyService, this._studyImageUpdateService);

  int? _studyId;
  int _headCount = 0;
  String _studyName = '', _studyDescription = '', _studyImagePath = '';
  List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];
  int _studyMemberCount = 15;
  File? _file;
  bool _isStudyNameError = false;
  bool _isStudyDescriptionError = false;
  bool _isOldImageLoaded = false;

  @override
  bool get isOldImageLoaded => _isOldImageLoaded;

  @override
  String get studyImagePath => _studyImagePath;

  @override
  String get studyDescription => _studyDescription;

  @override
  String get studyName => _studyName;

  @override
  List<String> get selectedCategories => _selectedCategories;

  @override
  List<int> get selectedCategoryIndices => _selectedCategoryIndices;

  @override
  File? get studyImageFile => _file;

  @override
  int get studyMemberCount => _studyMemberCount;

  @override
  bool get isStudyNameError => _isStudyNameError;

  @override
  bool get isStudyDescriptionError => _isStudyDescriptionError;

  @override
  bool checkEverythingFilled() {
    if (_isStudyNameError &&
        _isStudyDescriptionError &&
        // (!isStudyDiscloseToggled || studyDisclosePassword.length == 4) &&
        _studyMemberCount >= _headCount &&
        _selectedCategories.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

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

  @override
  void updateStudyNameAndDescription(NewStudyType type, String input) {
    switch (type) {
      case NewStudyType.studyName:
        _studyName = input;
        // debugPrint(_studyName);
        break;
      case NewStudyType.studyDescription:
        _studyDescription = input;
        break;
      // debugPrint(_studyDescription);
    }
  }

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

  @override
  void updateSelectedCategoryIndices() {
    _selectedCategoryIndices = _selectedCategories
        .map((category) => getStudyCategories().indexOf(category))
        .toList();
    print(_selectedCategories);
    print(_selectedCategoryIndices);
  }

  @override
  set memberCount(int newValue) {
    if (newValue >= _headCount && newValue <= 15) {
      _studyMemberCount = newValue;
      debugPrint('스터디 인원: $_studyMemberCount');
      notifyListeners();
    }
  }

  @override
  set studyImageFile(File? file) {
    _file = file;
    _studyImagePath = file!.path;

    notifyListeners();
  }

  @override
  set isOldImageLoaded(bool value) {
    _isOldImageLoaded = value;
    notifyListeners();
  }

  /// call api

  Future<void> getStudyInfo(int studyId) async {
    StudyModel study = await _studyService.fetchStudyInfo(studyId);
    _studyId = study.id;
    _headCount = study.headcount;
    _studyName = study.studyName;
    _studyImagePath = study.studyImage!;
    studyImageFile = File(study.studyImage!);
    _studyDescription = study.explanation;
    _selectedCategories = study.categories;
    _studyMemberCount = study.headcount;
    notifyListeners();
  }

  Future<void> updateStudyImage() async {
    if (_file != null) {
      int studyImageId =
          await _studyImageUpdateService.callCreateApi(_studyId!, _file!);
      print('studyImageID : $studyImageId');
    } else {
      return;
    }
  }

  Future<void> updateStudyInfo() async {
    await updateStudyImage();
    StudyModel study = await _studyService.updateStudyInfo(
        _studyId!,
        UpdatedStudyInfo(_studyName, _studyDescription,
            _selectedCategoryIndices..sort(), _studyMemberCount));
    print(study);
  }
}
