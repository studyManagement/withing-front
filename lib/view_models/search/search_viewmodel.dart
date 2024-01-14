import 'package:flutter/material.dart';

class SearchViewModel with ChangeNotifier {
  String? _selectedFilterValue;
  int? _selectedCategoryValue;

  String? get selectedFilterValue => _selectedFilterValue;
  int? get selectedCategoryValue => _selectedCategoryValue;

  /// filter : selected value notifier
  set selectedFilterValue(String? value) {
    _selectedFilterValue = value;
    notifyListeners();
  }

  /// category : selected value notifier
  set selectedCategoryValue(int? value) {
    _selectedCategoryValue = value;
    notifyListeners();
  }

  SearchViewModel() {
    _selectedFilterValue = '최신순';
    _selectedCategoryValue = 0;
  }
}
