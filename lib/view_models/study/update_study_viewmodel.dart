import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/view_models/study/model/updated_study_info.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import '../../service/image/image_update_service.dart';
import '../../service/study/study_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class UpdateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyService _studyService;
  final ImageUpdateService _imageUpdateService;

  UpdateStudyViewModel(this._studyService, this._imageUpdateService);

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

  int? _studyId;
  int _headCount = 0;
  int? _studyImageId;
  String _studyName = '', _studyDescription = '', _studyImagePath = '';
  List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];
  int _studyMemberCount = 0;
  File? _file;
  bool _isStudyNameError = false;
  bool _isStudyDescriptionError = false;
  bool _isOldImageLoaded = false;

  @override
  bool checkEverythingFilled() {
    if (_isStudyNameError &&
        _isStudyDescriptionError &&
        _studyMemberCount >= _headCount) {
      return true;
    }
    return false;
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
        break;
      case NewStudyType.studyDescription:
        _studyDescription = input;
        break;
    }
  }

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

  @override
  void updateSelectedCategoryIndices() {
    _selectedCategoryIndices = _selectedCategories
        .map((category) => getStudyCategories().indexOf(category))
        .toList();
  }

  @override
  set memberCount(int newValue) {
    if (newValue <= 15) {
      _studyMemberCount = newValue;
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

  void setStudyNameAdnDescription(){
    checkStudyNameAndDescription(NewStudyType.studyName, _studyName);
    checkStudyNameAndDescription(NewStudyType.studyDescription, _studyDescription);
  }


  /// call api
  Future<void> getStudyInfo(int studyId) async {
    StudyModel study = await _studyService.fetchStudyInfo(studyId);
    _studyId = study.id;
    _headCount = study.headcount;
    _studyName = study.studyName;
    _studyImagePath = study.studyImage ?? '';
    if (_studyImagePath.isNotEmpty) studyImageFile = File(study.studyImage!);
    _studyDescription = study.explanation;
    _selectedCategories = List.from(study.categories);
    _studyMemberCount = study.max;
    setStudyNameAdnDescription();
    notifyListeners();
  }

  @override
  Future<void> callImageApi() async {
    if (_file != null) {
      _studyImageId =
          await _imageUpdateService.callImageUpdateApi(_studyId!, _file!);
    } else {
      return;
    }
  }

  Future<void> updateStudyInfo() async {
    // await updateStudyImage();
    await _studyService.updateStudyInfo(
        _studyId!,
        UpdatedStudyInfo(_studyName, _studyDescription,
            _selectedCategoryIndices..sort(), _studyMemberCount));
  }
}
