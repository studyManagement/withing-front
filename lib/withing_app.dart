import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/common/theme/withing_theme.dart';
import 'package:withing/views/study/screen/study_manage_screen.dart';

import 'package:withing/views/study/screen/study_member_screen.dart';
import 'package:withing/views/study/screen/study_screen.dart';

import 'package:withing/views/new_study/new_study_screen.dart';

import 'package:withing/views/login/login_screen.dart';
import 'package:withing/views/my/my_profile_screen.dart';
import 'package:withing/views/my/my_study_screen.dart';
import 'package:withing/views/search/screen/search_result_screen.dart';
import 'package:withing/views/search/screen/keyword_search_screen.dart';

import '../views/signup/signup_screen.dart';

class WithingApp extends StatelessWidget {
  WithingApp({super.key});

  final router = GoRouter(
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
          path: '/my/profile', builder: (context, state) => MyProfileScreen()),
      GoRoute(
          path: '/my/studies', builder: (context, state) => MyStudyScreen()),
      GoRoute(
        path: '/search/result',
        builder: (context, state) => KeywordSearchScreen(),
      ),
      GoRoute(
        path: '/studies/new',
        builder: (context, state) => const NewStudyScreen(),
      ),
      GoRoute(
        path: '/studies/:studyId',
        builder: (context, state) =>
            StudyScreen(studyId: int.parse(state.pathParameters['studyId']!)),
        routes: [
          GoRoute(
            path: 'manage',
            builder: (context, state) => const StudyManageScreen(),
          ),
          GoRoute(
              path: 'member',
              builder: (context, state) => const StudyMemberScreen())
        ]),
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: WithingTheme.withingThemeData,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
