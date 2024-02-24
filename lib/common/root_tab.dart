import 'package:flutter/material.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/service/study/study_service.dart';
import 'package:modi/view_models/study/study_list_viewmodel.dart';
import 'package:modi/views/my/my_screen.dart';
import 'package:modi/views/notification/notification_screen.dart';
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
    tabController = TabController(length: 5, vsync: this);
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
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          tabController.animateTo(index);
        },
        currentIndex: index,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/home.png',
              width: 32,
              height: 32,
              color: index == 0 ? Colors.black : Colors.grey,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/search.png',
              width: 32,
              height: 32,
              color: index == 1 ? Colors.black : Colors.grey,
            ),
            label: '검색',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/calendar.png',
              width: 32,
              height: 32,
              color: index == 2 ? Colors.black : Colors.grey,
            ),
            label: '일정',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/bell.png',
              width: 32,
              height: 32,
              color: index == 3 ? Colors.black : Colors.grey,
            ),
            label: '알림',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'asset/user.png',
              width: 32,
              height: 32,
              color: index == 4 ? Colors.black : Colors.grey,
            ),
            label: '마이 페이지',
          ),
        ],
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
          const NotificationScreen(),
          const MyScreen(),
        ],
      ),
    );
  }
}
