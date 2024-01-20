import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/theme/app/app_colors.dart';
import 'package:withing/common/theme/app/app_fonts.dart';
import 'package:withing/view_models/study/study_viewmodel.dart';

class HomeStudyNotificator extends StatelessWidget {
  HomeStudyNotificator({super.key});

  final PageController _pageController = PageController();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<StudyView> studies = context.select<StudyViewModel, List<StudyView>>(
        (provider) => provider.studyViews);

    const pageCount = 3;

    return (studies.isNotEmpty)
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.gray50,
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
                    color: AppColors.gray50,
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
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 159,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.gray50,
              ),
              child: const Center(
                child: Text(
                  '해당 날짜에는\n등록된 일정이 없어요.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.gray300,
                      fontWeight: AppFonts.fontWeight500),
                ),
              ),
            ),
          );
  }
}
