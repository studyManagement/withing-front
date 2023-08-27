import 'package:go_router/go_router.dart';
import 'package:withing/screens/login/login_screen.dart';
import 'package:withing/screens/splash/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      routes: [
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
        ),
      ],
    ),
  ],
);
