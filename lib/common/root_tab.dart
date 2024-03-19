import 'package:flutter/material.dart';
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
    return DefaultLayout(
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.gray150,
            ),
          ),
        ),
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _makeNavigatorButton(0, 'asset/home.png'),
            _makeNavigatorButton(1, 'asset/search.png'),
            _makeNavigatorButton(2, 'asset/calendar.png'),
            _makeNavigatorButton(3, 'asset/user.png'),
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

  Expanded _makeNavigatorButton(int tabIndex, String asset) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () => tabController.animateTo(tabIndex),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          height: 60,
          child: Image.asset(
            asset,
            width: 32,
            height: 32,
            color: index == tabIndex ? Colors.black : Colors.grey,
          ),
        ),
      ),
    );
  }
}
