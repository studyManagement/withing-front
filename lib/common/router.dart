import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';

import 'package:withing/views/study/study_screen.dart';
import 'package:withing/views/create/create_study_screen.dart';

import 'package:withing/views/login/login_screen.dart';
import 'package:withing/views/my/my_profile_screen.dart';
import 'package:withing/views/my/my_study_screen.dart';
import 'package:withing/views/signup/signup_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const RootTab()),
    GoRoute(
        path: '/signup/:provider/:uuid',
        builder: (context, GoRouterState state) {
          final provider = state.pathParameters['provider']!;
          final socialUUID = state.pathParameters['uuid']!;

          return SignupScreen(provider, socialUUID);
        }),
    GoRoute(
        path: '/my/profile', builder: (context, state) => MyProfileScreen()),
    GoRoute(path: '/my/studies', builder: (context, state) => MyStudyScreen()),
    GoRoute(
      path: '/studies/new',
      builder: (context, state) => const CreateStudyScreen(),
    ),
    GoRoute(
      path: '/studies/:studyId',
      builder: (context, state) =>
          StudyScreen(studyId: int.parse(state.pathParameters['studyId']!)),
    ),
  ],
);
