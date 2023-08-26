import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const RootTab()),
  ],
);
