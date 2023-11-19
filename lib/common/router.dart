import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/screens/login/login_screen.dart';
import 'package:withing/screens/signup/signup_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(path: '/signup', builder: (context, state) => const SignupScreen()),
    GoRoute(path: '/home', builder: (context, state) => const RootTab()),
  ],
);
