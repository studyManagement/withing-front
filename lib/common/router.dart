import 'package:go_router/go_router.dart';
import 'package:withing/onboarding/screen/splash_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
  ],
);
