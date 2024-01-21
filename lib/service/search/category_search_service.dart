import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import 'package:withing/model/search/searched_study_info_model.dart';
import '../../common/requester/network_exception.dart';

part 'category_search_service.g.dart';

/// API
@RestApi()
abstract class CategorySearchApi {
  factory CategorySearchApi(Dio dio, {String baseUrl}) = _CategorySearchApi;

  @GET("/studies/search")
  Future<List<SearchedStudyInfo>> search(
    @Query("category_id") String categoryId,
    @Query("sort") String sort,
    @Query("index") String index,
  );

  @GET("/studies/count")
  Future<int> count(
    @Query("category_id") String categoryId,
  );
}

/// Service
class CategorySearchService {
  final CategorySearchApi _api;

  CategorySearchService(this._api);

  Future<List<SearchedStudyInfo>> callSearchApi(
    String categoryId,
    String sort,
    String index,
  ) async {
    try {
      debugPrint('[API]');
      final response = await _api.search(categoryId, sort, index);
      print(response);
      return response;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> callCountApi(
    String categoryId,
  ) async {
    try {
      debugPrint('[API]');
      final studyCnt = await _api.count(categoryId);
      debugPrint('검색된 스터디 수 :  $studyCnt');
      return studyCnt;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }
}
