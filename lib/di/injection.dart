import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/service/signin/signin_service.dart';
import 'package:withing/service/signup/signup_service.dart';
import 'package:withing/service/study/study_service.dart';

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

  getIt.registerLazySingleton<SignupApi>(
    () => SignupApi(RequestBuilder.getInstance()),
  );

  getIt.registerLazySingleton<SigninApi>(
    () => SigninApi(RequestBuilder.getInstance()),
  );

  getIt.registerLazySingleton<StudyApi>(
    () => StudyApi(RequestBuilder.getInstance()),
  );

  /// Repository
  getIt.registerLazySingleton<CategorySearchRepository>(
    () => CategorySearchRepository(getIt<CategorySearchDataSource>()),
  );

  getIt.registerLazySingleton<SignupService>(
      () => SignupService(getIt<SignupApi>()));

  getIt.registerLazySingleton<SigninService>(
      () => SigninService(getIt<SigninApi>()));

  getIt.registerLazySingleton<StudyService>(
      () => StudyService(getIt<StudyApi>()));
}
