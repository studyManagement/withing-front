import 'package:flutter/material.dart';

class TextInputValidationProvider with ChangeNotifier {
  bool? _isStudyNameError;
  bool? _isStudyDescriptionError;

  bool? get isStudyNameError => _isStudyNameError;
  bool? get isStudyDescriptionError => _isStudyDescriptionError;

  /// text input validation : study name
  void validateStudyName(String input) {
    _isStudyNameError = _validateInput(input, r'^.{2,20}$');
    notifyListeners();
  }

  /// text input validation : study description
  void validateStudyDescription(String input) {
    _isStudyDescriptionError = _validateInput(input, r'^.{1,65}$');
    notifyListeners();
  }

  bool? _validateInput(String input, String pattern) {
    final isValid = RegExp(pattern).hasMatch(input);
    return isValid ? true : false;
  }

  TextInputValidationProvider() {
    _isStudyNameError = false;
    _isStudyDescriptionError = false;
  }
}
