import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/root_tab.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/image/study_image_update_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/view_models/study/update_study_viewmodel.dart';
import 'package:modi/views/board/screen/board_main_screen.dart';
import 'package:modi/views/common/error_page.dart';
import 'package:modi/views/create/create_study_screen.dart';
import 'package:modi/views/login/login_screen.dart';
import 'package:modi/views/my/my_profile_screen.dart';
import 'package:modi/views/my/my_study_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_add_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_vote_add_screen.dart';
import 'package:modi/views/search/screen/keyword_search_screen.dart';
import 'package:modi/views/signup/signup_screen.dart';
import 'package:modi/views/study/screen/study_info_screen.dart';
import 'package:modi/views/study/screen/study_update_screen.dart';
import 'package:provider/provider.dart';

class RouterService {
  final LoggingInterface _logger = getIt<LoggingInterface>();
  static final RouterService _instance = RouterService._privateConstructor();
  static RouterService get instance => _instance;
  late final GoRouter _goRouter;
  GoRouter get router => _goRouter;

  RouterService._privateConstructor() {
    _goRouter = GoRouter(
        debugLogDiagnostics: kDebugMode ? true : false,
        observers: [_logger.getObserver()],
        redirect: (BuildContext context, GoRouterState state) {
          bool isAuthentication = Authentication.state.isAuthentication;

          if (state.matchedLocation == "/my/profile") {
            return '/test';
          }

          if (!isAuthentication &&
              (state.matchedLocation != '/login' &&
                  !state.matchedLocation.startsWith('/signup/'))) {
            return '/login';
          }
          return null;
        },
        initialLocation:
            (Authentication.state.isAuthentication) ? '/' : '/login',
        refreshListenable: Authentication.state,
        errorBuilder: (context, state) => const ErrorPage(),
        routes: [
          GoRoute(
              path: '/login', builder: (context, state) => const LoginScreen()),
          GoRoute(
            path: '/',
            builder: (context, state) => const RootTab(),
            routes: [
              GoRoute(
                path: 'my/profile',
                builder: (context, state) => MyProfileScreen(),
              ),
              GoRoute(
                path: 'my/studies/:type',
                builder: (context, state) {
                  final studyType = state.pathParameters['type']!;

                  return MultiProvider(
                    providers: [
                      ChangeNotifierProvider(
                          create: (_) =>
                              StudyListViewModel(getIt<StudyService>())),
                    ],
                    child: MyStudyScreen(studyType),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/signup/:provider/:uuid',
            builder: (context, GoRouterState state) {
              final provider = state.pathParameters['provider']!;
              final uuid = state.pathParameters['uuid']!;
              return SignupScreen(provider, uuid);
            },
          ),
          GoRoute(
            path: '/search/result',
            builder: (context, state) => KeywordSearchScreen(),
          ),
          GoRoute(
            path: '/studies/new',
            builder: (context, state) => const CreateStudyScreen(),
          ),
          GoRoute(
            path: '/studies/:studyId',
            builder: (context, state) {
              return ChangeNotifierProvider(
                  create: (_) => StudyViewModel(getIt<StudyService>()),
                  child: StudyInfoScreen(
                    studyId: int.parse(state.pathParameters['studyId']!),
                  ));
            },
          ),
          GoRoute(
            path: '/studies/:studyId/schedules',
            builder: (context, state) => StudyScheduleScreen(
                int.parse(state.pathParameters['studyId']!)),
          ),
          GoRoute(
            path: '/studies/:studyId/schedules/register',
            builder: (context, state) => StudyScheduleAddScreen(
                int.parse(state.pathParameters['studyId']!)),
          ),
          GoRoute(
            path: '/studies/:studyId/schedules/vote',
            builder: (context, state) => StudyScheduleVoteAddScreen(
                int.parse(state.pathParameters['studyId']!)),
          ),
          // GoRoute(
          //   path: '/studies/:studyId/member',
          //   builder: (context, state) => StudyMemberScreen(
          //       studyId: int.parse(state.pathParameters['studyId']!)
          //   ),
          // ),
          // GoRoute(
          //     path: '/studies/:studyId/manage',
          //     builder: (context, state) => StudyManageScreen(
          //         studyId: int.parse(state.pathParameters['studyId']!))),
          GoRoute(
            path: '/studies/:studyId/manage/edit',
            builder: (context, state) => ChangeNotifierProvider(
              create: (_) => UpdateStudyViewModel(
                  getIt<StudyService>(), getIt<StudyImageUpdateService>()),
              child: StudyUpdateScreen(
                  studyId: int.parse(state.pathParameters['studyId']!)),
            ),
          ),
          // GoRoute(
          //   path: '/studies/:studyId/manage/regular_meeting',
          //   builder: (context, state) => const SetRegularMeetingScreen(),
          // ),
          GoRoute(
            path: '/studies/:studyId/boards', // 게시판
            builder: (context, state) => BoardMainScreen(
                studyId: int.parse(state.pathParameters['studyId']!),
                isNotice: false),
          ),
          // GoRoute(
          //     path: '/studies/:studyId/boards/create', // 게시판 글 작성
          //     builder: (context, state) => CreatePostScreen(
          //           studyId: int.parse(state.pathParameters['studyId']!),
          //          )),
          // GoRoute(
          //     path: '/studies/:studyId/boards/update/:boardId', // 게시판 글 수정
          //     builder: (context, state) => UpdatePostScreen(
          //       studyId: int.parse(state.pathParameters['studyId']!),
          //       boardId: int.parse(state.pathParameters['boardId']!),
          //     )),
          GoRoute(
            path: '/studies/:studyId/boards/notice', // 공지 전체보기
            builder: (context, state) => BoardMainScreen(
                studyId: int.parse(state.pathParameters['studyId']!),
                isNotice: true),
          ),

          // GoRoute(
          //     path: '/studies/:studyId/boards/:boardId', // 게시판(공지) 상세
          //     builder: (context, state) => BoardInfoScreen(
          //         studyId: int.parse(state.pathParameters['studyId']!),
          //         isNotice: false,
          //         boardId: int.parse(state.pathParameters['boardId']!)))
        ]);
  }
}
