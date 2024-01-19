import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/service/signin/signin_service.dart';
import 'package:withing/service/signup/signup_service.dart';
import '../service/search/category_search_service.dart';
import '../service/study/study_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  /// Dio
  getIt.registerLazySingleton<Dio>(
    () => RequestBuilder.getInstance(),
    instanceName: 'client',
  );

  /// Api
  getIt.registerLazySingleton<SignupApi>(
    () => SignupApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<SigninApi>(
    () => SigninApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<CategorySearchApi>(
    () => CategorySearchApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudyApi>(
    () => StudyApi(getIt<Dio>(instanceName: 'client')),
  );

  /// Service
  getIt.registerLazySingleton<SignupService>(
    () => SignupService(getIt<SignupApi>()),
  );
  getIt.registerLazySingleton<SigninService>(
    () => SigninService(getIt<SigninApi>()),
  );
  getIt.registerLazySingleton<CategorySearchService>(
    () => CategorySearchService(getIt<CategorySearchApi>()),
  );
  getIt.registerLazySingleton<StudyService>(
    () => StudyService(getIt<StudyApi>()),
  );
}
