import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:withing/data/model/category_search_model.dart';

part 'category_search_data_source.g.dart';

// Retrofit API Interface
@RestApi(baseUrl: "https://openapi.naver.com/v1/search")
abstract class CategorySearchApi {
  factory CategorySearchApi(Dio dio, {String baseUrl}) = _CategorySearchApi;

  @GET("/image")
  Future<CategorySearchModel> search(
    @Query("category_id") String categoryId,
  );
}

// Data Source Class
class CategorySearchDataSource {
  final CategorySearchApi _categorySearchApi;

  CategorySearchDataSource(this._categorySearchApi);

  Future<CategorySearchModel> callPlaceImageSearchApi(
    String categoryId,
  ) async {
    try {
      final response = await _categorySearchApi.search(
        categoryId,
      );

      return response;
    } on DioException catch (e) {
      rethrow;
    }
  }
}
