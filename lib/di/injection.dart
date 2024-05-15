import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:modi/common/logger/logger_service.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/requester/request_builder.dart';
import 'package:modi/service/board/board_service.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/service/signin/signin_service.dart';
import 'package:modi/service/signup/signup_service.dart';

import '../service/create/study_create_service.dart';
import '../service/image/image_create_service.dart';
import '../service/image/image_update_service.dart';
import '../service/search/study_search_service.dart';
import '../service/study/study_service.dart';
import '../service/user/user_service.dart';

final GetIt getIt = GetIt.instance;

void setupDependencyInjection() {
  // Logger
  getIt.registerLazySingleton<LoggingInterface>(() => LoggerService.instance);

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
  getIt.registerLazySingleton<UserApi>(
        () => UserApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudyApi>(
    () => StudyApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudySearchApi>(
    () => StudySearchApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<StudyCreateApi>(
    () => StudyCreateApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<ImageCreateApi>(
    () => ImageCreateApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<ImageUpdateApi>(
    () => ImageUpdateApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<BoardApi>(
    () => BoardApi(getIt<Dio>(instanceName: 'client')),
  );
  getIt.registerLazySingleton<ScheduleApi>(
    () => ScheduleApi(getIt<Dio>(instanceName: 'client')),
  );

  /// Service
  getIt.registerLazySingleton<SignupService>(
    () => SignupService(getIt<SignupApi>()),
  );
  getIt.registerLazySingleton<SigninService>(
    () => SigninService(getIt<SigninApi>()),
  );
  getIt.registerLazySingleton<UserService>(
        () => UserService(getIt<UserApi>()),
  );
  getIt.registerLazySingleton<StudyService>(
    () => StudyService(getIt<StudyApi>()),
  );
  getIt.registerLazySingleton<StudySearchService>(
    () => StudySearchService(getIt<StudySearchApi>()),
  );
  getIt.registerLazySingleton<ScheduleService>(
    () => ScheduleService(getIt<ScheduleApi>()),
  );
  getIt.registerLazySingleton<StudyCreateService>(
    () => StudyCreateService(getIt<StudyCreateApi>()),
  );
  getIt.registerLazySingleton<ImageCreateService>(
    () => ImageCreateService(getIt<ImageCreateApi>()),
  );
  getIt.registerLazySingleton<ImageUpdateService>(
    () => ImageUpdateService(getIt<ImageUpdateApi>()),
  );
  getIt.registerLazySingleton<BoardService>(
    () => BoardService(getIt<BoardApi>()),
  );
}
