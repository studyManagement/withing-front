import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/models/signup/signup_service.dart';
import 'package:withing/views/login/login_screen.dart';
import 'package:withing/views/signup/signup_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const LoginScreen()),
    GoRoute(
        path: '/signup',
        builder: (context, state) => Provider(
              create: (context) => SignupService(),
              child: const SignupScreen(),
            )),
    GoRoute(path: '/home', builder: (context, state) => const RootTab()),
  ],
);
