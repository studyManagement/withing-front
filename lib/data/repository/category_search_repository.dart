import '../data_source/search/category_search_data_source.dart';
import '../model/category_search_model.dart';

class CategorySearchRepository {
  final CategorySearchDataSource _dataSource;

  CategorySearchRepository(this._dataSource);

  Future<CategorySearchModel> searchStudies(String categoryId) async {
    return _dataSource.callPlaceImageSearchApi(categoryId);
  }
}
