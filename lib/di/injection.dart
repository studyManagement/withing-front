import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../data/data_resources.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  /// Dio
  getIt.registerLazySingleton<Dio>(
    () => Dio(),
    instanceName: 'DioClient',
  );

  /// Api
  getIt.registerLazySingleton<CategorySearchApi>(
    () => CategorySearchApi(getIt<Dio>(instanceName: 'DioClient')),
  );

  /// DataSource
  getIt.registerLazySingleton<CategorySearchDataSource>(
    () => CategorySearchDataSource(getIt<CategorySearchApi>()),
  );

  /// Repository
  getIt.registerLazySingleton<CategorySearchRepository>(
    () => CategorySearchRepository(getIt<CategorySearchDataSource>()),
  );
}
