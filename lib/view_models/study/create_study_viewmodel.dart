import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/network_exception.dart';
import 'package:modi/model/study/study_model.dart';
import 'package:modi/view_models/study/study_info_viewmodel.dart';
import '../../common/requester/api_exception.dart';
import '../../common/utils/get_image_file.dart';
import '../../di/injection.dart';
import '../../service/create/study_create_service.dart';
import '../../service/image/image_create_service.dart';
import '../../views/create/widgets/study_text_field.dart';

class CreateStudyViewModel extends StudyInfoViewModel with ChangeNotifier {
  final StudyCreateService _studyCreateService;

  CreateStudyViewModel(this._studyCreateService);

  @override
  String get studyDescription => _studyDescription;

  @override
  String get studyName => _studyName;

  @override
  String get password => _studyDisclosePassword;

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
  String _studyImagePath = 'asset/search_category/2_certification.png';
  File? _studyImageFile;
  int _studyMemberCount = 0;
  String _studyImageUuid = '';
  int? _studyId;

  int? get studyId => _studyId;
  final List<String> _selectedCategories = [];
  List<int> _selectedCategoryIndices = [];

  @override
  bool get isStudyNameError => _isStudyNameError;

  @override
  bool get isStudyDescriptionError => _isStudyDescriptionError;

  @override
  String get studyImagePath => _studyImagePath;

  @override
  bool isOldImage = true;
  @override
  bool isDefault = true;

  @override
  String get studyImageUuid => _studyImageUuid;

  @override
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
  @override
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
        .map((category) => getStudyCategories().indexOf(category)+1)
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


  /// update study password
  @override
  set password(String newValue) {
    if (newValue.length == 4) {
      _studyDisclosePassword = newValue;
      notifyListeners();
    } else {
      _studyDisclosePassword = '';
      notifyListeners();
    }
  }

  /// update study image
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

  /// create study api
  Future<void> createStudy(BuildContext context) async {
    try {
      if(_studyImageUuid.isEmpty){
        _studyImageFile = await getImageFileFromAssets(_studyImagePath);
        _studyImageUuid = await getIt<ImageCreateService>().callImageCreateApi(_studyImageFile!);
      }
      print(_selectedCategoryIndices..sort());
      final StudyModel newStudy = await _studyCreateService.callCreateApi(
        _studyName,
        _studyMemberCount,
        (isStudyDiscloseToggled) ? 1 : 0,
        _studyDisclosePassword,
        _studyDescription,
        _selectedCategoryIndices..sort(),
        _studyImageUuid,
      );
      _studyId = newStudy.id;
    } on ApiException catch (e) {
      if (!context.mounted) return;
      ModiModal.openDialog(context, '오류가 발생했어요', e.cause, false,
          () => context.pop(), () => null);
    } on NetworkException catch (e) {
      rethrow;
    }
    notifyListeners();
  }
}
