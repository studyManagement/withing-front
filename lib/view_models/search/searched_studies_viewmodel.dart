import 'package:intl/intl.dart';
import '../../model/search/searched_study_info_model.dart';

abstract class SearchedStudiesViewModel {
  int get studiesCount;
  dynamic get selectedValue;
  String get filterValue;
  List<SearchedStudyInfo>? get studyList;
  Future<void> search();
  Future<void> scrollListener();
  void updateSearchFilterValue(String value);
}

/// utils
///
///

const int size = 10;

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
      return '최신순';
  }
}

