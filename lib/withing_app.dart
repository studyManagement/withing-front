import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/authenticator/authentication.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/common/theme/withing_theme.dart';
import 'package:withing/views/board/screen/board_info_screen.dart';
import 'package:withing/views/board/screen/board_main_screen.dart';
import 'package:withing/views/board/screen/create_post_screen.dart';
import 'package:withing/views/create/create_study_screen.dart';
import 'package:withing/views/login/login_screen.dart';
import 'package:withing/views/my/my_profile_screen.dart';
import 'package:withing/views/my/my_study_screen.dart';
import 'package:withing/views/search/screen/keyword_search_screen.dart';
import 'package:withing/views/study/study_screen_resources.dart';

import '../views/signup/signup_screen.dart';

class WithingApp extends StatelessWidget {
  const WithingApp({super.key});

  GoRouter makeRoute() {
    return GoRouter(
        redirect: (BuildContext context, GoRouterState state) {
          bool isAuthentication = Authentication.state.isAuthentication;

          if (!isAuthentication &&
              (state.matchedLocation != '/' &&
                  !state.matchedLocation.startsWith('/signup/'))) {
            return '/';
          }

          return null;
        },
        initialLocation:
            (Authentication.state.isAuthentication) ? '/home' : '/',
        refreshListenable: Authentication.state,
        routes: [
          GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
          GoRoute(path: '/home', builder: (context, state) => const RootTab()),
          GoRoute(
              path: '/signup/:provider/:uuid',
              builder: (context, GoRouterState state) {
                final provider = state.pathParameters['provider']!;
                final uuid = state.pathParameters['uuid']!;
                return SignupScreen(provider, uuid);
              }),
          GoRoute(
              path: '/my/profile',
              builder: (context, state) => MyProfileScreen()),
          GoRoute(
              path: '/my/studies',
              builder: (context, state) => const MyStudyScreen()),
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
              builder: (context, state) => StudyScreen(
                  studyId: int.parse(state.pathParameters['studyId']!))),
          GoRoute(
            path: '/studies/:studyId/member',
            builder: (context, state) => const StudyMemberScreen(),
          ),
          GoRoute(
              path: '/studies/:studyId/manage',
              builder: (context, state) => StudyManageScreen(
                  studyId: int.parse(state.pathParameters['studyId']!))),
          GoRoute(
            path: '/studies/:studyId/manage/edit',
            builder: (context, state) => StudyEditScreen(
                studyId: int.parse(state.pathParameters['studyId']!)),
          ),
          GoRoute(
            path: '/studies/:studyId/manage/regular_meeting',
            builder: (context, state) => const SetRegularMeetingScreen(),
          ),
          GoRoute(
              path: '/studies/:studyId/board', // 게시판
              builder: (context, state) => BoardMainScreen(
                  studyId: int.parse(state.pathParameters['studyId']!),
                  isNotice: false)),
          GoRoute(
              path: '/studies/:studyId/board/create', // 게시판 글 작성
              builder: (context, state) => CreatePostScreen(
                  studyId: int.parse(state.pathParameters['studyId']!),
                  )),
          GoRoute(
              path: '/studies/:studyId/board/notice', // 공지 전체보기
              builder: (context, state) => BoardMainScreen(
                  studyId: int.parse(state.pathParameters['studyId']!),
                  isNotice: true)),
          GoRoute(
              path: '/studies/:studyId/board/:boardId', // 게시판(공지) 상세
              builder: (context, state) => BoardInfoScreen(
                  studyId: int.parse(state.pathParameters['studyId']!),
                  isNotice: false,
                  boardId: int.parse(state.pathParameters['boardId']!)))
        ]);
  }

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp.router(
      theme: WithingTheme.withingThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: makeRoute(),
    );
  }
}
