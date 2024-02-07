import 'package:go_router/go_router.dart';
import 'package:modi/common/root_tab.dart';
import 'package:modi/views/create/create_study_screen.dart';
import 'package:modi/views/login/login_screen.dart';
import 'package:modi/views/my/my_profile_screen.dart';
import 'package:modi/views/signup/signup_screen.dart';
import 'package:modi/views/study/screen/study_info_screen.dart';

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
    GoRoute(
      path: '/studies/new',
      builder: (context, state) => const CreateStudyScreen(),
    ),
  ],
);
