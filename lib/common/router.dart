import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/views/study/screen/study_screen.dart';
import 'package:withing/views/new_study/new_study_screen.dart';
import 'package:withing/views/login/login_screen.dart';
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
      path: '/studies/new',
      builder: (context, state) => const NewStudyScreen(),
    ),
    GoRoute(
      path: '/studies/:studyId',
      builder: (context, state) =>
          StudyScreen(studyId: int.parse(state.pathParameters['studyId']!)),
    ),
  ],
);
