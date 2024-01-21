import 'package:flutter/material.dart';
import '../../model/search/searched_study_info_model.dart';
import '../../service/search/category_search_service.dart';
import '../../service/search/keyword_search_service.dart';

enum SearchType { category, keyword }

class SearchStudyViewModel with ChangeNotifier {
  final CategorySearchService _categorySearchService;
  final KeywordSearchService _keywordSearchService;

  SearchStudyViewModel(this._categorySearchService, this._keywordSearchService);

  String _selectedCategoryFilterValue = '최신순';
  String _selectedKeywordFilterValue = '최신순';
  String _keywordValue = '';
  int _selectedCategoryValue = 0;
  int _studyCountWithCategory = 0;
  int _studyCountWithKeyword = 0;
  List<SearchedStudyInfo>? _searchedStudiesWithCategory;
  List<SearchedStudyInfo>? _searchedStudiesWithKeyword;

  String get categoryFilterValue => _selectedCategoryFilterValue;
  String get keywordFilterValue => _selectedKeywordFilterValue;
  String get keywordValue => _keywordValue;
  int get selectedCategoryValue => _selectedCategoryValue;
  int get studyCountWithCategory => _studyCountWithCategory;
  int get studyCountWithKeyword => _studyCountWithKeyword;
  List<SearchedStudyInfo>? get studyWithCategory =>
      _searchedStudiesWithCategory;
  List<SearchedStudyInfo>? get studyWithKeyword => _searchedStudiesWithKeyword;

  /// update search filter
  void updateSearchFilterValue(SearchType type, String value) {
    switch (type) {
      case SearchType.category:
        _selectedCategoryFilterValue = value;
        break;
      case SearchType.keyword:
        _selectedKeywordFilterValue = value;
        break;
    }
    notifyListeners();
  }

  /// update search category
  set searchCategory(int newValue) {
    _selectedCategoryValue = newValue;
    notifyListeners();
  }

  /// update search keyword
  set searchKeyword(String newValue) {
    _keywordValue = newValue;
    debugPrint(_keywordValue);
    notifyListeners();
  }

  /// update study count with category search
  set studyCountWithCategory(int newValue) {
    _studyCountWithCategory = newValue;
    notifyListeners();
  }

  /// update study count with keyword search
  set studyCountWithKeyword(int newValue) {
    _studyCountWithKeyword = newValue;
    notifyListeners();
  }

  /// category search api
  Future<void> categorySearch() async {
    String id = _selectedCategoryValue.toString();
    _studyCountWithCategory = await _categorySearchService.callCountApi(id);
    notifyListeners();

    _searchedStudiesWithCategory = await _categorySearchService.callSearchApi(
      id,
      getFilter(_selectedCategoryFilterValue),
      "0", // index
    );
    notifyListeners();
  }

  /// keyword search api
  Future<void> keywordSearch() async {
    _studyCountWithKeyword =
        await _keywordSearchService.callCountApi(_keywordValue);
    notifyListeners();

    _searchedStudiesWithKeyword = await _keywordSearchService.callSearchApi(
      _keywordValue,
      getFilter(_selectedCategoryFilterValue),
      "0", // index
    );
    notifyListeners();
  }
}

///
/// Utils - search study

List<String> getStudyFilters() {
  return const ['최신순', '인기순'];
}

String getFilter(String value) {
  switch (value) {
    case '최신순':
      return 'created_at';
    case '인기순':
      return 'popularity';
    default:
      debugPrint('올바른 필터 형식이 아닙니다.');
      return '최신순';
  }
}
