import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:withing/common/requester/request_builder.dart';
import 'package:withing/service/signin/signin_service.dart';
import 'package:withing/service/signup/signup_service.dart';
import '../service/create/study_create_service.dart';
import '../service/image/study_image_create_service.dart';
import '../service/search/category_search_service.dart';
import '../service/search/keyword_search_service.dart';
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
  getIt.registerLazySingleton<StudyApi>(
    () => StudyApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<CategorySearchApi>(
    () => CategorySearchApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<KeywordSearchApi>(
    () => KeywordSearchApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudyCreateApi>(
    () => StudyCreateApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudyImageCreateApi>(
    () => StudyImageCreateApi(getIt<Dio>(instanceName: 'client')),
  );

  /// Service
  getIt.registerLazySingleton<SignupService>(
    () => SignupService(getIt<SignupApi>()),
  );
  getIt.registerLazySingleton<SigninService>(
    () => SigninService(getIt<SigninApi>()),
  );
  getIt.registerLazySingleton<StudyService>(
    () => StudyService(getIt<StudyApi>()),
  );
  getIt.registerLazySingleton<CategorySearchService>(
    () => CategorySearchService(getIt<CategorySearchApi>()),
  );
  getIt.registerLazySingleton<KeywordSearchService>(
    () => KeywordSearchService(getIt<KeywordSearchApi>()),
  );
  getIt.registerLazySingleton<StudyCreateService>(
    () => StudyCreateService(getIt<StudyCreateApi>()),
  );
  getIt.registerLazySingleton<StudyImageCreateService>(
    () => StudyImageCreateService(getIt<StudyImageCreateApi>()),
  );
}
