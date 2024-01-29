import '../../model/search/searched_study_info_model.dart';

abstract class SearchedStudiesViewModel {
  int get searchesCount;
  List<SearchedStudyInfo>? get studyList;
  Future<void> scrollListener();

  /// scroll listener 예시
  //   Future<void> scrollListener() async {
  //     if (_isLoading) return;
  //     _isLoading = true;
  //
  //     fetchStudies(); // 추가 데이터 요청
  //
  //     _isLoading = false;
  //   }
}
