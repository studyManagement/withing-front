// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/search/searched_study_info_model.dart';
import '../../service/search/category_search_service.dart';
import '../../service/search/keyword_search_service.dart';

enum SearchType { category, keyword }

class SearchStudyViewModel with ChangeNotifier {
  final CategorySearchService _categorySearchService;
  final KeywordSearchService _keywordSearchService;

  SearchStudyViewModel(
      this._categorySearchService, this._keywordSearchService) {
    categorySearch();
  }

  String _selectedCategoryFilterValue = '최신순';
  String _selectedKeywordFilterValue = '최신순';
  String _keywordValue = '';
  int _selectedCategoryValue = 0;
  int _studyCountWithCategory = 0;
  int _studyCountWithKeyword = 0;
  List<SearchedStudyInfo>? _searchedStudiesWithCategory;
  List<SearchedStudyInfo>? _searchedStudiesWithKeyword;
  bool _isLoading = false;

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
    _searchedStudiesWithCategory = [];
    notifyListeners();
  }

  /// update search keyword
  set searchKeyword(String newValue) {
    _keywordValue = newValue;
    _searchedStudiesWithKeyword = [];
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

  /// category initial search api
  Future<void> categorySearch() async {
    String id = _selectedCategoryValue.toString();
    _studyCountWithCategory = await _categorySearchService.callCountApi(id);
    notifyListeners();

    if (_studyCountWithCategory != 0) {
      _searchedStudiesWithCategory = await _categorySearchService.callSearchApi(
        id,
        getFilter(_selectedCategoryFilterValue),
        0,
      );
    }

    debugPrint('검색된 스터디(카테고리)');
    print(_searchedStudiesWithCategory);
    notifyListeners();
  }

  /// keyword initial search api
  Future<void> keywordSearch() async {
    _studyCountWithKeyword =
        await _keywordSearchService.callCountApi(_keywordValue);
    notifyListeners();

    if (_studyCountWithKeyword != 0) {
      _searchedStudiesWithKeyword = await _keywordSearchService.callSearchApi(
        _keywordValue,
        getFilter(_selectedCategoryFilterValue),
        0,
      );
    }

    debugPrint('검색된 스터디(키워드)');
    print(_searchedStudiesWithKeyword);
    notifyListeners();
  }

  /// fetch category search - 스크롤시 추가
  Future<void> fetchStudiesWithCategory() async {
    debugPrint('API 추가 요청 - 카테고리');
    String id = _selectedCategoryValue.toString();
    int currentLength = _searchedStudiesWithCategory != null
        ? _searchedStudiesWithCategory!.length
        : 0;

    if (currentLength < _studyCountWithCategory) {
      List<SearchedStudyInfo>? newStudies =
          await _categorySearchService.callSearchApi(
        id,
        getFilter(_selectedCategoryFilterValue),
        currentLength,
      );

      _searchedStudiesWithCategory?.addAll(newStudies);
      notifyListeners();
      print(_searchedStudiesWithCategory!.length);
    }
  }

  /// fetch keyword search - 스크롤시 추가
  Future<void> fetchStudiesWithKeyword() async {
    debugPrint('API 추가 요청 - 키워드');
    int currentLength = _searchedStudiesWithKeyword != null
        ? _searchedStudiesWithKeyword!.length
        : 0;

    if (currentLength < _studyCountWithKeyword) {
      List<SearchedStudyInfo>? newStudies =
          await _keywordSearchService.callSearchApi(
        _keywordValue,
        getFilter(_selectedKeywordFilterValue),
        currentLength,
      );

      _searchedStudiesWithKeyword?.addAll(newStudies);
      notifyListeners();
      print(_searchedStudiesWithKeyword!.length);
    }
  }

  /// scroll listener
  Future<void> scrollListener(SearchType type) async {
    if (_isLoading) return;
    _isLoading = true;

    (type == SearchType.category)
        ? await fetchStudiesWithCategory()
        : await fetchStudiesWithKeyword();

    _isLoading = false;
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

String convertMeetingDetails(List<MeetingInfo> meetings) {
  Map<int, String> dayNames = {
    1: '월요일',
    2: '화요일',
    3: '수요일',
    4: '목요일',
    5: '금요일',
    6: '토요일',
    7: '일요일'
  };

  DateFormat inputFormat = DateFormat('HH:mm');
  DateFormat outputFormat = DateFormat('h:mm');

  List<String> meetingStrings = [];

  for (var meeting in meetings) {
    DateTime startTime = inputFormat.parse(meeting.startTime);
    DateTime endTime = inputFormat.parse(meeting.endTime);

    String startPeriod = startTime.hour >= 12 ? '오후' : '오전';
    int startHour = startTime.hour >= 12 ? startTime.hour - 12 : startTime.hour;
    startHour = startHour == 0 ? 12 : startHour;

    String endPeriod = endTime.hour >= 12 ? '오후' : '오전';
    int endHour = endTime.hour >= 12 ? endTime.hour - 12 : endTime.hour;
    endHour = endHour == 0 ? 12 : endHour;

    String formattedStartTime = outputFormat.format(startTime);
    String formattedEndTime = outputFormat.format(endTime);

    // String meetingTime =
    //     '$startPeriod $formattedStartTime - $endPeriod $formattedEndTime';
    String meetingTime = '$startPeriod $formattedStartTime';
    String meetingDay = dayNames[meeting.day]!;

    // meetingStrings.isEmpty
    //     ? meetingStrings.add('매주 $meetingDay $meetingTime')
    //     : meetingStrings.add('        $meetingDay $meetingTime');

    meetingStrings.add('매주 $meetingDay $meetingTime');
  }

  return meetingStrings.join('\n');
}
