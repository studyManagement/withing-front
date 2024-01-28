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
    @Query("index") int index,
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
    int index,
  ) async {
    // try {
    //   debugPrint('[API]');
    //   final response = await _api.search(categoryId, sort, index);
    //   print(response);
    //   return response;
    // } on NetworkException catch (e) {
    //   print(e);
    //   rethrow;
    // }

    List<SearchedStudyInfo> mockResponse = [
      SearchedStudyInfo(
          studyId: 1,
          studyName: "Study 1",
          max: 10,
          headCount: 5,
          studyImage: null,
          categories: [1, 2],
          regularMeetingId: 101,
          gap: 1,
          days: [1, 3, 5], // 월, 수, 금
          startTime: "18:00",
          endTime: "20:00"),
      SearchedStudyInfo(
          studyId: 2,
          studyName: "Study 2",
          max: 15,
          headCount: 8,
          studyImage: null,
          categories: [3, 4],
          regularMeetingId: 102,
          gap: 0,
          days: [],
          startTime: "10:00",
          endTime: "12:00"),
    ];

    return mockResponse;
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
