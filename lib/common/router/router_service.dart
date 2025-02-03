import 'dart:convert';
import 'dart:io';

import 'package:app_links/app_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/authenticator/authentication.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/root_tab.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/schedule/schedule_viewmodel.dart';
import 'package:modi/view_models/schedule/schedule_vote_viewmodel.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/view_models/study/study_viewmodel.dart';
import 'package:modi/view_models/study/update_study_viewmodel.dart';
import 'package:modi/views/board/screen/board_main_screen.dart';
import 'package:modi/views/common/error_page.dart';
import 'package:modi/views/create/create_study_screen.dart';
import 'package:modi/views/login/login_screen.dart';
import 'package:modi/views/my/my_profile_screen.dart';
import 'package:modi/views/my/my_study_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_add_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_detail_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_vote_add_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_vote_choice_screen.dart';
import 'package:modi/views/schedule/study/study_schedule_vote_detail_screen.dart';
import 'package:modi/views/search/screen/keyword_search_screen.dart';
import 'package:modi/views/signup/signup_screen.dart';
import 'package:modi/views/study/screen/study_info_screen.dart';
import 'package:modi/views/study/screen/study_update_screen.dart';
import 'package:provider/provider.dart';
import '../../service/user/user_service.dart';
import '../../view_models/my/update_profile_viewmodel.dart';
import '../../views/schedule/study/study_schedule_vote_confirm_screen.dart';
import '../../views/schedule/study/study_schedule_vote_members_screen.dart';

class RouterService {
  final LoggingInterface _logger = getIt<LoggingInterface>();
  static final RouterService _instance = RouterService._privateConstructor();
  static bool _isInitialize = false;

  static bool get isInitialize => _isInitialize;

  static RouterService get instance => _instance;
  late final GoRouter _goRouter;
  late final AppLinks _appLinks;
  GoRouter get router => _goRouter;

  bool isBase64(String str) {
    try {
      base64.decode(str);
      return true;
    } catch (e) {
      return false;
    }
  }

  initializeRoute() async {
    try {
      _appLinks = AppLinks();
      final Uri? uri = await _appLinks.getInitialLink();
      if (uri != null && kIsWeb) {
        _goRouter.go(uri.path);
        return;
      }

      if (uri != null && Platform.isIOS) {
        _goRouter.go(utf8.decode(base64.decode(uri.path)));
      }

      _appLinks.uriLinkStream.listen((uri) async { // 분기 처리 필요
        if (Platform.isIOS) {
          var route = "";
          const host = "modiapp:/";
          if (uri.toString().startsWith(host)) {
            route = uri.toString().substring(host.length);
            route = utf8.decode(route.codeUnits);
          }
          else {
            route = uri.path;
            if (route.startsWith('/')) {
              route = route.substring(1);
            }
            if (isBase64(route)) {
              route = utf8.decode(base64Decode(route));
            }
          }
          _goRouter.go(route);
        }
      });
    } catch (e) {
      _logger.error(e);
    } finally {
      RouterService._isInitialize = true;
    }
  }

  RouterService._privateConstructor() {
    _goRouter = GoRouter(
        debugLogDiagnostics: kDebugMode ? true : false,
        observers: [_logger.getObserver()],
        redirect: (BuildContext context, GoRouterState state) {
          bool isAuthentication = Authentication.state.isAuthentication;

          if (!isAuthentication &&
              (state.matchedLocation != '/login' &&
                  !state.matchedLocation.startsWith('/signup/'))) {
            return '/login';
          }
          return null;
        },
        initialLocation:
            (Authentication.state.isAuthentication) ? '/' : '/login',
        refreshListenable: Authentication.state,
        errorBuilder: (context, state) {
          if (kDebugMode) {
            print(state);
          }
          return const ErrorPage();
        },
        routes: [
          GoRoute(
              path: '/login', builder: (context, state) => const LoginScreen()),
          GoRoute(
            path: '/search',
            builder: (context, state) => const RootTab(index: 1),
          ),
          GoRoute(
              path: '/',
              builder: (context, state) {
                return const RootTab();
              },
              routes: [
                // GoRoute(
                //   path: 'notification',
                //   builder: (context, state) => const NotificationScreen(),
                // ),
                GoRoute(
                  path: 'my/profile',
                  builder: (context, state) {
                    final viewModel = state.extra ??
                        UpdateProfileViewModel(context, getIt<UserService>());
                    return MyProfileScreen(
                        viewModel: viewModel as UpdateProfileViewModel);
                  },
                ),
                GoRoute(
                  path: 'my/studies/:type',
                  builder: (context, state) {
                    final studyType = state.pathParameters['type']!;

                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (_) => StudyListViewModel(
                              getIt<StudyService>(), context),
                        ),
                      ],
                      child: MyStudyScreen(studyType),
                    );
                  },
                ),
                GoRoute(
                  path: 'search/result',
                  builder: (context, state) => const KeywordSearchScreen(),
                ),
                GoRoute(
                  path: 'studies/new',
                  builder: (context, state) => const CreateStudyScreen(),
                ),
                GoRoute(
                  path: 'studies/:studyId',
                  builder: (context, state) {
                    final refreshFlag = state.extra ?? false;
                    return ChangeNotifierProvider(
                        create: (_) =>
                            StudyViewModel(context, getIt<StudyService>()),
                        child: StudyInfoScreen(
                            studyId: int.parse(
                              state.pathParameters['studyId']!,
                            ),
                            refreshFlag: refreshFlag as bool));
                  },
                  routes: [
                    GoRoute(
                      path: 'schedules',
                      builder: (context, state) {
                        ScheduleService service = getIt<ScheduleService>();
                        return MultiProvider(
                          providers: [
                            ChangeNotifierProvider(
                              create: (_) => ScheduleViewModel(service),
                            ),
                            ChangeNotifierProvider(
                              create: (_) => ScheduleVoteViewModel(service),
                            ),
                          ],
                          child: StudyScheduleScreen(
                            int.parse(state.pathParameters['studyId']!),
                          ),
                        );
                      },
                      routes: [
                        GoRoute(
                          path: 'register',
                          builder: (context, state) {
                            int studyId =
                                int.parse(state.pathParameters['studyId']!);
                            int? scheduleId = state
                                        .uri.queryParameters['scheduleId'] !=
                                    null
                                ? int.parse(
                                    state.uri.queryParameters['scheduleId']!)
                                : null;

                            return ChangeNotifierProvider(
                              create: (_) => ScheduleViewModel(
                                getIt<ScheduleService>(),
                              ),
                              child: StudyScheduleAddScreen(
                                studyId,
                                scheduleId,
                              ),
                            );
                          },
                        ),
                        GoRoute(
                          path: 'vote',
                          builder: (context, state) {
                            int studyId =
                                int.parse(state.pathParameters['studyId']!);
                            return ChangeNotifierProvider(
                              create: (_) => ScheduleVoteViewModel(
                                getIt<ScheduleService>(),
                              ),
                              child: StudyScheduleVoteAddScreen(studyId),
                            );
                          },
                        ),
                        GoRoute(
                          path: 'vote/:voteId/edit',
                          builder: (context, state) {
                            int studyId =
                                int.parse(state.pathParameters['studyId']!);
                            int voteId =
                                int.parse(state.pathParameters['voteId']!);

                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                  create: (_) => ScheduleVoteViewModel(
                                    getIt<ScheduleService>(),
                                  ),
                                ),
                                ChangeNotifierProvider(
                                  create: (_) => StudyViewModel(
                                    context,
                                    getIt<StudyService>(),
                                  ),
                                ),
                              ],
                              child: StudyScheduleVoteChoiceScreen(
                                studyId,
                                voteId,
                              ),
                            );
                          },
                        ),
                        GoRoute(
                          path: 'vote/:voteId',
                          builder: (context, state) {
                            int studyId =
                                int.parse(state.pathParameters['studyId']!);
                            int voteId =
                                int.parse(state.pathParameters['voteId']!);

                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                  create: (_) => ScheduleVoteViewModel(
                                    getIt<ScheduleService>(),
                                  ),
                                ),
                                ChangeNotifierProvider(
                                  create: (_) => StudyViewModel(
                                    context,
                                    getIt<StudyService>(),
                                  ),
                                ),
                              ],
                              child: StudyScheduleVoteDetailScreen(
                                studyId,
                                voteId,
                              ),
                            );
                          },
                          routes: [
                            GoRoute(
                              path: 'members',
                              builder: (context, state) {
                                int studyId =
                                    int.parse(state.pathParameters['studyId']!);
                                int voteId =
                                    int.parse(state.pathParameters['voteId']!);
                                return ChangeNotifierProvider(
                                  create: (_) => ScheduleVoteViewModel(
                                    getIt<ScheduleService>(),
                                  ),
                                  child: StudyScheduleVoteMembersScreen(
                                      studyId, voteId),
                                );
                              },
                            ),
                            GoRoute(
                              path: 'confirm',
                              builder: (context, state) {
                                int studyId =
                                    int.parse(state.pathParameters['studyId']!);
                                int voteId =
                                    int.parse(state.pathParameters['voteId']!);
                                return ChangeNotifierProvider(
                                  create: (_) {
                                    return ScheduleVoteViewModel(
                                      getIt<ScheduleService>(),
                                    );
                                  },
                                  child: StudyScheduleVoteConfirmScreen(
                                    studyId,
                                    voteId,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        GoRoute(
                          path: ':scheduleId',
                          builder: (context, state) {
                            int studyId =
                                int.parse(state.pathParameters['studyId']!);
                            int studyScheduleId =
                                int.parse(state.pathParameters['scheduleId']!);

                            return MultiProvider(
                              providers: [
                                ChangeNotifierProvider(
                                  create: (_) => ScheduleViewModel(
                                    getIt<ScheduleService>(),
                                  ),
                                ),
                                ChangeNotifierProvider(
                                  create: (_) => StudyViewModel(
                                    context,
                                    getIt<StudyService>(),
                                  ),
                                ),
                              ],
                              child: StudyScheduleDetailScreen(
                                studyId: studyId,
                                studyScheduleId: studyScheduleId,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    GoRoute(
                      path: 'manage/edit',
                      builder: (context, state) => ChangeNotifierProvider(
                        create: (_) => UpdateStudyViewModel(
                            getIt<StudyService>(), context),
                        child: StudyUpdateScreen(
                            studyId:
                                int.parse(state.pathParameters['studyId']!)),
                      ),
                    ),
                    GoRoute(
                      path: 'boards', // 게시판
                      builder: (context, state) => BoardMainScreen(
                          studyId: int.parse(state.pathParameters['studyId']!),
                          isNotice: false,
                          isMember: true),
                    ),
                    GoRoute(
                      path: 'notice/:isMember', // 공지 전체보기
                      builder: (context, state) => BoardMainScreen(
                        studyId: int.parse(state.pathParameters['studyId']!),
                        isNotice: true,
                        isMember: (state.pathParameters['isMember'] == 'true')
                            ? true
                            : false,
                      ),
                    ),
                  ],
                ),
              ]),
          GoRoute(
            path: '/signup/:provider/:uuid',
            builder: (context, GoRouterState state) {
              final provider = state.pathParameters['provider']!;
              final uuid = state.pathParameters['uuid']!;
              return SignupScreen(provider, uuid);
            },
          ),
        ]);
  }
}
