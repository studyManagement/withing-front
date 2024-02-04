import 'package:flutter/cupertino.dart';
import 'package:modi/view_models/search/searched_studies_viewmodel.dart';

import '../../model/search/searched_study_info_model.dart';
import '../../service/search/keyword_search_service.dart';

class KeywordSearchViewModel extends SearchedStudiesViewModel
    with ChangeNotifier {
  final KeywordSearchService _keywordSearchService;

  KeywordSearchViewModel(this._keywordSearchService) {
    search();
  }

  bool _isLoading = false;
  String _selectedFilterValue = '최신순';
  String _selectedKeywordValue = '';
  int _studyCount = 0;
  List<SearchedStudyInfo>? _searchedStudies;

  @override
  String get filterValue => _selectedFilterValue;

  @override
  dynamic get selectedValue => _selectedKeywordValue;

  @override
  int get studiesCount => _studyCount;

  @override
  List<SearchedStudyInfo>? get studyList => _searchedStudies;

  @override
  Future<void> scrollListener() async {
    if (_isLoading) return;
    _isLoading = true;

    await fetchStudiesWithKeyword();

    _isLoading = false;
  }

  /// update search filter
  @override
  void updateSearchFilterValue(String value) {
    _selectedFilterValue = value;
    notifyListeners();
  }

  /// keyword initial search api
  @override
  Future<void> search() async {
    String id = _selectedKeywordValue.toString();
    _studyCount = await _keywordSearchService.callCountApi(id);
    notifyListeners();

    if (_studyCount != 0) {
      _searchedStudies = await _keywordSearchService.callSearchApi(
        id,
        getFilter(_selectedFilterValue),
        0,
      );
    }

    debugPrint('검색된 스터디(카테고리)');
    print(_searchedStudies);
    notifyListeners();
  }

  /// update search keyword
  set searchKeyword(String newValue) {
    _selectedKeywordValue = newValue;
    _searchedStudies = [];
    notifyListeners();
  }

  /// update study count with keyword search
  set studyCountWithKeyword(int newValue) {
    _studyCount = newValue;
    notifyListeners();
  }

  /// fetch keyword search - 스크롤시 추가
  Future<void> fetchStudiesWithKeyword() async {
    debugPrint('API 추가 요청 - 키워드');
    String id = _selectedKeywordValue.toString();
    int currentLength = _searchedStudies != null ? _searchedStudies!.length : 0;

    if (currentLength < _studyCount) {
      List<SearchedStudyInfo>? newStudies =
          await _keywordSearchService.callSearchApi(
        selectedValue,
        getFilter(_selectedFilterValue),
        currentLength,
      );

      _searchedStudies?.addAll(newStudies);
      notifyListeners();
      print(_searchedStudies!.length);
    }
  }
}
