import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:withing/data/model/category_search_model.dart';

part 'category_search_data_source.g.dart';

/// Api
@RestApi(baseUrl: "http://3.34.129.8:8080")
abstract class CategorySearchApi {
  factory CategorySearchApi(Dio dio, {String baseUrl}) = _CategorySearchApi;

  @GET("/studies/search")
  Future<CategorySearchModel> search(
    @Query("category") String categoryId,
  );
}

/// DataSource
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
