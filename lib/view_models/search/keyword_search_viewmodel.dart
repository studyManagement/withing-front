import 'package:flutter/cupertino.dart';
import 'package:modi/view_models/search/searched_studies_viewmodel.dart';
import '../../model/search/searched_study_info_model.dart';
import '../../service/search/study_search_service.dart';

class KeywordSearchViewModel extends SearchedStudiesViewModel
    with ChangeNotifier {
  final StudySearchService _studySearchService;

  KeywordSearchViewModel(this._studySearchService) {
    search();
  }

  bool _isLoading = false;
  bool _isInitLoading = true;
  String _selectedFilterValue = '최신순';
  String _selectedKeywordValue = '';
  int _studyCount = 0;
  List<SearchedStudyInfo> _searchedStudies = [];

  @override
  String get filterValue => _selectedFilterValue;

  @override
  dynamic get selectedValue => _selectedKeywordValue;

  @override
  int get studiesCount => _studyCount;

  @override
  List<SearchedStudyInfo> get studyList => _searchedStudies;

  @override
  bool get isInitLoading => _isInitLoading;

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
    _searchedStudies = [];
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


  /// keyword initial search api
  @override
  Future<void> search() async {
    String keyword = _selectedKeywordValue.toString();
    _studyCount = await _studySearchService.callKeywordCountApi(keyword);
    notifyListeners();

   if(_searchedStudies.length < _studyCount) {
      _searchedStudies = await _studySearchService.callSearchApi(
          getFilter(_selectedFilterValue), // 정렬 키워드
          keyword, // 카테고리 이름
          "keyword",
          size,
          0
      );
    }
    _isInitLoading = false;
    notifyListeners();
  }

  /// fetch keyword search - 스크롤시 추가
  Future<void> fetchStudiesWithKeyword() async {
    String keyword = _selectedKeywordValue.toString();
    int page = _searchedStudies.isNotEmpty ? _searchedStudies.length ~/ size : 0;

    if (_searchedStudies.length < _studyCount) {
      List<SearchedStudyInfo>? newStudies =
          await _studySearchService.callSearchApi(
              getFilter(_selectedFilterValue), // 정렬 키워드
              keyword, // 카테고리 이름
              "keyword",
              size,
              page
      );

      _searchedStudies.addAll(newStudies);
      notifyListeners();
    }
  }
}
