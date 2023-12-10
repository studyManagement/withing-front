import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/screens/new-study/new_study_screen.dart';
import 'package:withing/screens/study/study_screen.dart';
import 'package:withing/views/login/login_screen.dart';

import '../models/signup/signup_service.dart';
import '../views/signup/signup_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/home', builder: (context, state) => const RootTab()),
    GoRoute(
        path: '/signup/:provider/:accessToken',
        builder: (context, GoRouterState state) {
          final provider = state.pathParameters['provider']!;
          final accessToken = state.pathParameters['accessToken']!;

          return Provider(
            create: (context) => SignupService(),
            child: SignupScreen(provider, accessToken),
          );
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
