import 'package:flutter/material.dart';
import 'package:withing/data/model/category_search_model.dart';
import 'package:withing/data/repository/category_search_repository.dart';

class SearchViewModel with ChangeNotifier {
  final CategorySearchRepository _repository;
  CategorySearchModel? categorySearchModel;

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

  /// category search api
  Future<void> categorySearch(String categoryId) async {
    categorySearchModel = await _repository.searchStudies(categoryId);
    notifyListeners();
  }

  SearchViewModel(this._repository) {
    _selectedFilterValue = '최신순';
    _selectedCategoryValue = 0;
  }
}
