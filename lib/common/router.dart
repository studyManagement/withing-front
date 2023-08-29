import 'package:go_router/go_router.dart';
import 'package:withing/screens/home/home_screen.dart';
import 'package:withing/screens/login/login_screen.dart';
import 'package:withing/screens/signup/signup_screen.dart';
import 'package:withing/screens/splash/splash_screen.dart';

import '../screens/search/search_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: 'signup',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: 'search',
          builder: (context, state) => const SearchScreen(),
        ),
      ],
    ),
  ],
);
