import 'package:dio/dio.dart' hide Headers;
import 'package:flutter/material.dart';
import 'package:retrofit/http.dart';
import 'package:withing/model/search/searched_study_list_model.dart';

import '../../common/requester/network_exception.dart';

part 'category_search_service.g.dart';

/// API
@RestApi()
abstract class CategorySearchApi {
  factory CategorySearchApi(Dio dio, {String baseUrl}) = _CategorySearchApi;

  @GET("/studies/search")
  Future<List<StudyInfo>> search(
    @Query("category_id") String categoryId,
    @Query("sort") String sort,
    @Query("index") String index,
  );
}

class CategorySearchService {
  final CategorySearchApi _api;

  CategorySearchService(this._api);

  Future<List<StudyInfo>> callApi(
    String categoryId,
    String sort,
    String index,
  ) async {
    try {
      final response = await _api.search(categoryId, sort, index);
      debugPrint('[API]');
      print(response);
      return response;
    } on NetworkException catch (e) {
      rethrow;
    }
    // final mockResponse = SearchedStudyListModel.fromJson({
    //   "code": 200,
    //   "message": "스터디 목록을 조회했습니다.",
    //   "data": [
    //     {
    //       "studyId": 1,
    //       "studyName": "스터디1",
    //       "max": 15,
    //       "headcount": 2,
    //       "studyImage": "asset",
    //       "categoryList": [],
    //       "regularMeetingId": 0,
    //       "gap": 0,
    //       "day1": 1,
    //       "day2": 2,
    //       "day3": 3,
    //       "startTime": "18:12:12",
    //       "endTime": "20:13:13",
    //     },
    //     {
    //       "studyId": 2,
    //       "studyName": "스터디2",
    //       "max": 15,
    //       "headcount": 2,
    //       "studyImage": "asset",
    //       "categoryList": [],
    //       "regularMeetingId": 0,
    //       "gap": 0,
    //       "day1": 1,
    //       "day2": 2,
    //       "day3": 3,
    //       "startTime": "18:12:12",
    //       "endTime": "20:13:13",
    //     },
    //     {
    //       "studyId": 3,
    //       "studyName": "스터디3",
    //       "max": 15,
    //       "headcount": 2,
    //       "studyImage": "asset",
    //       "categoryList": [],
    //       "regularMeetingId": 0,
    //       "gap": 0,
    //       "day1": 1,
    //       "day2": 2,
    //       "day3": 3,
    //       "startTime": "18:12:12",
    //       "endTime": "20:13:13",
    //     },
    //     {
    //       "studyId": 4,
    //       "studyName": "스터디4",
    //       "max": 15,
    //       "headcount": 2,
    //       "studyImage": "asset",
    //       "categoryList": [],
    //       "regularMeetingId": 0,
    //       "gap": 0,
    //       "day1": 1,
    //       "day2": 2,
    //       "day3": 3,
    //       "startTime": "18:12:12",
    //       "endTime": "20:13:13",
    //     },
    //     {
    //       "studyId": 5,
    //       "studyName": "스터디5",
    //       "max": 15,
    //       "headcount": 2,
    //       "studyImage": "asset",
    //       "categoryList": [],
    //       "regularMeetingId": 0,
    //       "gap": 0,
    //       "day1": 1,
    //       "day2": 2,
    //       "day3": 3,
    //       "startTime": "18:12:12",
    //       "endTime": "20:13:13",
    //     },
    //   ],
    //   "success": true
    // });
    // debugPrint('[Mock]');
    // print(mockResponse);
    // return mockResponse;
  }
}
