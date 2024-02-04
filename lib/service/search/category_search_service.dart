import 'package:dio/dio.dart' hide Headers;
import 'package:modi/model/search/searched_study_info_model.dart';
import 'package:retrofit/http.dart';

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

    List<SearchedStudyInfo> mockResponse = List.generate(
      10,
      (index) => const SearchedStudyInfo(
        id: 3,
        teamName: '헬로우',
        max: 15,
        headcount: 3,
        password: "1111",
        explanation: "안녕하세요",
        createdDate: "2024-01-18T17:56:26.000+00:00",
        deadline: "2024-02-09T15:00:00.000+00:00",
        leaderId: 1,
        studyImage:
            "https://withing-bucket.s3.ap-northeast-2.amazonaws.com/중국.png",
        categories: ["어학", "자격증", "취미"],
        meetingSchedules: [
          // 월, 수, 토
          MeetingInfo(
            id: 1,
            day: 1,
            startTime: "11:00",
            endTime: "17:32",
          ),
          MeetingInfo(
            id: 1,
            day: 3,
            startTime: "11:00",
            endTime: "17:32",
          ),
          MeetingInfo(
            id: 1,
            day: 6,
            startTime: "11:00",
            endTime: "17:32",
          ),
        ],
        private: true,
        finished: false,
      ),
    );

    return mockResponse;
  }

  Future<int> callCountApi(
    String categoryId,
  ) async {
    // try {
    //   debugPrint('[API]');
    //   final studyCnt = await _api.count(categoryId);
    //   debugPrint('검색된 스터디 수 :  $studyCnt');
    //   return studyCnt;
    // } on NetworkException catch (e) {
    //   print(e);
    //   rethrow;
    // }

    int mockResponse = 100;

    return mockResponse;
  }
}
