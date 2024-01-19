import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:withing/service/study/StudyType.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';

import '../../common/layout/default_layout.dart';
import './main_calendar.dart';
import 'home_my_study.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  late final PageController _pageController;

  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    // 스터디 유무
    bool hasStudy = true;
    const pageCount = 3;

    final StudyViewModel vm = context.read<StudyViewModel>();
    vm.fetchStudies(StudyType.MY);

    return DefaultLayout(
      title: '이번주 일정',
      child: SafeArea(
        child: Column(
          children: [
            MainCalendar(
              onDaySelected: onDaySelected,
              selectedDate: selectedDate,
            ),
            // 만약 스터디가 있으면
            if (hasStudy)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey[100],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('11:00'),
                            SizedBox(width: 8),
                            VerticalDivider(
                                thickness: 1,
                                width: 10,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.grey),
                            SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '최강 마지막 네이버 면접 스터디 파이팅 테스트 테스트',
                                    style: TextStyle(color: Colors.blue),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 2),
                                  Text('실무 면접 및 대면 피드백'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.blueGrey[100],
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text('15:00'),
                            SizedBox(width: 8),
                            VerticalDivider(
                                thickness: 1,
                                width: 10,
                                indent: 20,
                                endIndent: 20,
                                color: Colors.grey),
                            SizedBox(width: 8),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '스터디 관리 사이드 프로젝트',
                                  style: TextStyle(color: Colors.blue),
                                ),
                                SizedBox(height: 2),
                                Text('5차 정기 회의(07:30'),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    // PageView(
                    //   controller: _pageController,
                    //   onPageChanged: (newIndex) {
                    //     setState(() {
                    //       index = newIndex;
                    //     });
                    //   },
                    //   children: [
                    //     Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 80,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //         color: Colors.blueGrey[100],
                    //       ),
                    //       child: const Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text('11:00'),
                    //             SizedBox(width: 8),
                    //             VerticalDivider(thickness: 1, width: 10, indent: 20, endIndent: 20, color: Colors.grey),
                    //             SizedBox(width: 8),
                    //             Expanded(
                    //               child: Column(
                    //                 mainAxisAlignment: MainAxisAlignment.center,
                    //                 crossAxisAlignment: CrossAxisAlignment.start,
                    //                 children: [
                    //                   Text(
                    //                     '최강 마지막 네이버 면접 스터디 파이팅 테스트 테스트',
                    //                     style: TextStyle(color: Colors.blue),
                    //                     overflow: TextOverflow.ellipsis,
                    //                   ),
                    //                   SizedBox(height: 2),
                    //                   Text('실무 면접 및 대면 피드백'),
                    //                 ],
                    //               ),
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(height: 8),
                    //     Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 80,
                    //       decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(12),
                    //         color: Colors.blueGrey[100],
                    //       ),
                    //       child: const Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8),
                    //         child: Row(
                    //           mainAxisAlignment: MainAxisAlignment.start,
                    //           children: [
                    //             Text('15:00'),
                    //             SizedBox(width: 8),
                    //             VerticalDivider(thickness: 1, width: 10, indent: 20, endIndent: 20, color: Colors.grey),
                    //             SizedBox(width: 8),
                    //             Column(
                    //               mainAxisAlignment: MainAxisAlignment.center,
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 Text(
                    //                   '스터디 관리 사이드 프로젝트',
                    //                   style: TextStyle(color: Colors.blue),
                    //                 ),
                    //                 SizedBox(height: 2),
                    //                 Text('5차 정기 회의(07:30'),
                    //               ],
                    //             )
                    //           ],
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: PageViewDotIndicator(
                        size: const Size(6, 6),
                        unselectedSize: const Size(6, 6),
                        currentItem: index,
                        count: pageCount,
                        unselectedColor: Colors.black26,
                        selectedColor: Colors.black,
                        duration: const Duration(milliseconds: 200),
                        boxShape: BoxShape.circle,
                        onItemClicked: (index) {
                          _pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            if (!hasStudy)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.grey[300],
                  ),
                  child: const Center(
                    child: Text(
                      '해당 날짜에는\n등록된 일정이 없어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Divider(
              thickness: 5,
              height: 1,
              color: Colors.grey[200],
            ),
            const HomeMyStudy(),
          ],
        ),
      ),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
      StudyViewModel vm = context.read<StudyViewModel>();
      vm.setSelectedDate(selectedDate);
    });
  }
}
