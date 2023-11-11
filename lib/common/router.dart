import 'package:go_router/go_router.dart';
import 'package:withing/common/root_tab.dart';
import 'package:withing/screens/new-study/new_study_screen.dart';
import 'package:withing/screens/search/search_screen.dart';
import 'package:withing/screens/study/study_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const RootTab()),
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
