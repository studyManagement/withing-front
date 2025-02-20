import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:modi/common/utils/get_image_file.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/service/image/image_create_service.dart';
import 'package:modi/view_models/study/model/updated_study_info.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import '../../common/modal/modi_modal.dart';
import '../../common/requester/api_exception.dart';
import '../../di/injection.dart';
import '../../service/study/study_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class UpdateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyService _studyService;
  final BuildContext _context;

  UpdateStudyViewModel(this._studyService, this._context);

  @override
  bool get isOldImage => _isOldImage;
  @override
  bool isDefault = true;

  @override
  String get studyDescription => _studyDescription;

  @override
  String get studyName => _studyName;

  @override
  List<String> get selectedCategories => _selectedCategories;

  @override
  List<int> get selectedCategoryIndices => _selectedCategoryIndices;

  @override
  File? get studyImageFile => _studyImageFile;

  @override
  String get studyImagePath => _studyImagePath;

  @override
  int get studyMemberCount => _studyMemberCount;

  @override
  bool get isStudyNameError => _isStudyNameError;

  @override
  bool get isStudyDescriptionError => _isStudyDescriptionError;

  @override
  String get studyImageUuid => _studyImageUuid;

  int? _studyId;
  int _headCount = 0;
  String _studyImageUuid = '';
  String _studyName = '', _studyDescription = '', _studyImagePath = '';
  List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];
  int _studyMemberCount = 0;
  File? _studyImageFile;
  bool _isStudyNameError = false;
  bool _isStudyDescriptionError = false;
  bool _isOldImage = true;
  bool isLoading = true;

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
        .map((category) => getStudyCategories().indexOf(category) + 1)
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
    _studyImageFile = file;
    notifyListeners();
  }

  @override
  set studyImagePath(String value) {
    _studyImagePath = value;
    notifyListeners();
  }

  @override
  set studyImageUuid(String value) {
    _studyImageUuid = value;
    notifyListeners();
  }

  @override
  set isOldImage(bool value) {
    _isOldImage = value;
    notifyListeners();
  }

  void setStudyNameAdnDescription() {
    checkStudyNameAndDescription(NewStudyType.studyName, _studyName);
    checkStudyNameAndDescription(
        NewStudyType.studyDescription, _studyDescription);
  }

  /// call api
  Future<void> getStudyInfo(int studyId) async {
    try {
      StudyModel study = await _studyService.fetchStudyInfo(studyId);
      _studyId = study.id;
      _headCount = study.headcount;
      _studyName = study.studyName;
      _studyImagePath = study.studyImage!;
      _studyImageFile = File(_studyImagePath);
      _studyDescription = study.explanation;
      _selectedCategories = List.from(study.categories)..remove('');
      updateSelectedCategoryIndices();
      _studyMemberCount = study.max;
      setStudyNameAdnDescription();
      isLoading = false;
      notifyListeners();
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    }
  }

  Future<void> updateStudyInfo() async {
    try {
      if (_studyImageUuid.isEmpty) {
        _studyImageFile = await fileFromImageUrl(_studyImagePath);
        _studyImageUuid = await getIt<ImageCreateService>()
            .callImageCreateApi(_studyImageFile!);
      }
      await _studyService.updateStudyInfo(
          _studyId!,
          UpdatedStudyInfo(
              _studyName,
              _studyDescription,
              _selectedCategoryIndices..sort(),
              _studyMemberCount,
              _studyImageUuid));
      notifyListeners();
      if (!_context.mounted) return;
      _context.go('/studies/$_studyId', extra: true);
    } on ApiException catch (e) {
      if (!_context.mounted) return;
      ModiModal.openDialog(_context, '오류가 발생했어요', e.cause, false,
          () => _context.pop(), () => null);
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
