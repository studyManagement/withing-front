import 'package:flutter/cupertino.dart';
import 'package:withing/view_models/search/searched_studies_viewmodel.dart';

import '../../model/search/searched_study_info_model.dart';
import '../../service/search/category_search_service.dart';

class CategorySearchViewModel extends SearchedStudiesViewModel
    with ChangeNotifier {
  final CategorySearchService _categorySearchService;

  CategorySearchViewModel(this._categorySearchService) {
    search();
  }

  bool _isLoading = false;
  String _selectedFilterValue = '최신순';
  int _selectedCategoryValue = 0;
  int _studyCount = 0;
  List<SearchedStudyInfo>? _searchedStudies;

  @override
  // TODO: implement filterValue
  String get filterValue => _selectedFilterValue;

  @override
  // TODO: implement selectedValue
  dynamic get selectedValue => _selectedCategoryValue;

  @override
  // TODO: implement searchesCount
  int get studiesCount => _studyCount;

  @override
  // TODO: implement studyList
  List<SearchedStudyInfo>? get studyList => _searchedStudies;

  @override
  Future<void> scrollListener() async {
    if (_isLoading) return;
    _isLoading = true;

    await fetchStudiesWithCategory();

    _isLoading = false;
  }

  /// update search filter
  @override
  void updateSearchFilterValue(String value) {
    _selectedFilterValue = value;
    debugPrint(_selectedFilterValue);
    notifyListeners();
  }

  /// category initial search api
  @override
  Future<void> search() async {
    String id = _selectedCategoryValue.toString();
    _studyCount = await _categorySearchService.callCountApi(id);
    notifyListeners();

    if (_studyCount != 0) {
      _searchedStudies = await _categorySearchService.callSearchApi(
        id,
        getFilter(_selectedFilterValue),
        0,
      );
    }

    debugPrint('검색된 스터디(카테고리)');
    print(_searchedStudies);
    notifyListeners();
  }

  /// update search category
  set searchCategory(int newValue) {
    _selectedCategoryValue = newValue;
    _searchedStudies = [];
    notifyListeners();
  }

  /// update study count with category search
  set studyCountWithCategory(int newValue) {
    _studyCount = newValue;
    notifyListeners();
  }

  /// fetch category search - 스크롤시 추가
  Future<void> fetchStudiesWithCategory() async {
    debugPrint('API 추가 요청 - 카테고리');
    String id = _selectedCategoryValue.toString();
    int currentLength = _searchedStudies != null ? _searchedStudies!.length : 0;

    if (currentLength < _studyCount) {
      List<SearchedStudyInfo>? newStudies =
          await _categorySearchService.callSearchApi(
        id,
        getFilter(_selectedFilterValue),
        currentLength,
      );

      _searchedStudies?.addAll(newStudies);
      notifyListeners();
      print(_searchedStudies!.length);
    }
  }
}

final List<String> categories = [
  '전체',
  '어학',
  '자격증',
  '취업',
  '시험',
  '취미',
  '프로그래밍',
  '기타'
];

final List<String> categoryImages = [
  'asset/search_category/0_entire.png',
  'asset/search_category/1_language.png',
  'asset/search_category/2_certification.png',
  'asset/search_category/3_employment.png',
  'asset/search_category/4_exam.png',
  'asset/search_category/5_hobby.png',
  'asset/search_category/6_programming.png',
  'asset/search_category/7_etc.png',
];
