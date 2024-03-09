import 'package:flutter/material.dart';
import 'package:modi/common/router/router_service.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/views/my/my_screen.dart';
import 'package:modi/views/schedule/schedule_screen.dart';
import 'package:provider/provider.dart';

import '../views/home/home_screen.dart';
import '../views/search/screen/category_search_screen.dart';
import 'layout/default_layout.dart';

class RootTab extends StatefulWidget {
  const RootTab({super.key});

  @override
  State<RootTab> createState() => _RootTabState();
}

class _RootTabState extends State<RootTab> with SingleTickerProviderStateMixin {
  late TabController tabController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);
    tabController.addListener(tabListener);
  }

  void tabListener() {
    setState(() {
      index = tabController.index;
    });
  }

  @override
  void dispose() {
    tabController.removeListener(tabListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RouterService.instance.router.refresh();

    return DefaultLayout(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.gray150,
            ),
          ),
        ),
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => tabController.animateTo(0),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'asset/home.png',
                  width: 32,
                  height: 32,
                  color: index == 0 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => tabController.animateTo(1),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'asset/search.png',
                  width: 32,
                  height: 32,
                  color: index == 1 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => tabController.animateTo(2),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'asset/calendar.png',
                  width: 32,
                  height: 32,
                  color: index == 2 ? Colors.black : Colors.grey,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => tabController.animateTo(3),
              child: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Image.asset(
                  'asset/user.png',
                  width: 32,
                  height: 32,
                  color: index == 3 ? Colors.black : Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
      child: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                  create: (_) => StudyListViewModel(getIt<StudyService>())),
            ],
            child: HomeScreen(),
          ),
          const CategorySearchScreen(),
          const ScheduleScreen(),
          const MyScreen(),
        ],
      ),
    );
  }
}
