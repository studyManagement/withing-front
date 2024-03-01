import 'package:dio/dio.dart' hide Headers;
import 'package:modi/model/search/searched_study_info_model.dart';
import 'package:retrofit/http.dart';
import '../../common/requester/network_exception.dart';
part 'study_search_service.g.dart';

/// API
@RestApi()
abstract class StudySearchApi {
  factory StudySearchApi(Dio dio, {String baseUrl}) = _StudySearchApi;

  @GET("/studies/search")
  Future<List<SearchedStudyInfo>> search(
      @Query("sort") String sort,
      @Query("keyword") String keyword,
      @Query("type") String type,
      @Query("size") int size,
      @Query("page") int page,
      );

  @GET("/studies/count")
  Future<int> countByCategory(
      @Query("category_id") int categoryId,
      );

  @GET("/studies/count")
  Future<int> countByKeyword(
      @Query("keyword") String keyword,
      );
}

/// Service
class StudySearchService {
  final StudySearchApi _api;

  StudySearchService(this._api);

  Future<List<SearchedStudyInfo>> callSearchApi(
      String sort,
      String keyword,
      String type,
      int size,
      int page
      ) async {
    try {
      final response = await _api.search(sort, keyword, type, size, page);
      return response;
    } on NetworkException catch (e) {
      rethrow;
    }

  }

  Future<int> callCategoryCountApi(
      int categoryId,
      ) async {
    try {
      final studyCnt = await _api.countByCategory(categoryId);
      return studyCnt;
    } on NetworkException catch (e) {
      rethrow;
    }
  }

  Future<int> callKeywordCountApi(
      String keyword,
      ) async {
    try {
      final studyCnt = await _api.countByKeyword(keyword);
      return studyCnt;
    } on NetworkException catch (e) {
      rethrow;
    }
  }
}
