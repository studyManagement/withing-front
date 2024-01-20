import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import 'package:withing/model/search/searched_study_list_model.dart';
import '../../common/requester/network_exception.dart';

part 'keyword_search_service.g.dart';

/// API
@RestApi()
abstract class KeywordSearchApi {
  factory KeywordSearchApi(Dio dio, {String baseUrl}) = _KeywordSearchApi;

  @GET("/studies/search")
  Future<List<StudyInfo>> search(
    @Query("keyword") String keyword,
    @Query("sort") String sort,
    @Query("index") String index,
  );

  @GET("/studies/count")
  Future<int> count(
    @Query("keyword") String keyword,
  );
}

/// Service
class KeywordSearchService {
  final KeywordSearchApi _api;

  KeywordSearchService(this._api);

  Future<List<StudyInfo>> callSearchApi(
    String keyword,
    String sort,
    String index,
  ) async {
    try {
      debugPrint('[API]');
      final response = await _api.search(keyword, sort, index);
      print(response);
      return response;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<int> callCountApi(
    String keyword,
  ) async {
    try {
      debugPrint('[API]');
      final studyCnt = await _api.count(keyword);
      debugPrint('검색된 스터디 수 :  $studyCnt');
      return studyCnt;
    } on NetworkException catch (e) {
      print(e);
      rethrow;
    }
  }
}
