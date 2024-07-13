// import 'package:flutter/material.dart';
// import 'package:modi/common/theme/app/app_colors.dart';
// import 'package:modi/common/theme/app/app_fonts.dart';
// import 'package:modi/view_models/study/model/study_list_view.dart';
// import 'package:modi/view_models/study/study_list_viewmodel.dart';
// import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
// import 'package:provider/provider.dart';
//
// class HomeStudyNotificationPageView extends StatefulWidget {
//   const HomeStudyNotificationPageView({super.key});
//
//   @override
//   State<StatefulWidget> createState() => _HomeStudyNotificationPageViewState();
// }
//
// class _HomeStudyNotificationPageViewState
//     extends State<HomeStudyNotificationPageView> {
//   late int selectedPage;
//   late final PageController _pageController;
//
//   @override
//   void initState() {
//     selectedPage = 0;
//     _pageController = PageController(initialPage: selectedPage);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DateTime selectedDate = context.select<StudyListViewModel, DateTime>(
//         (provider) => provider.selectedDate);
//     List<StudyListView> studies =
//         context.select<StudyListViewModel, List<StudyListView>>(
//             (provider) => provider.selectStudyListView);
//
//     return (studies.isNotEmpty)
//         ? Expanded(
//             child: Column(
//               children: [
//                 Expanded(
//                   child: PageView.builder(
//                     itemCount: (studies.length / 2).ceil(),
//                     controller: _pageController,
//                     onPageChanged: (page) {
//                       setState(() {
//                         selectedPage = page;
//                       });
//                     },
//                     itemBuilder: (context, index) {
//                       final int minIndex = index * 2;
//                       final List<Widget> widgets = [];
//
//                       widgets.add(
//                         HomeStudyNotificationPageViewItem(
//                           studies[minIndex].studyName,
//                           studies[minIndex].explanation,
//                           studies[minIndex].getPromise(selectedDate).startTime,
//                         ),
//                       );
//
//                       if (studies.length > minIndex + 1) {
//                         widgets.add(const SizedBox(height: 8));
//                         widgets.add(
//                           HomeStudyNotificationPageViewItem(
//                             studies[minIndex + 1].studyName,
//                             studies[minIndex + 1].explanation,
//                             studies[minIndex + 1]
//                                 .getPromise(selectedDate)
//                                 .startTime,
//                           ),
//                         );
//                       }
//
//                       return Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 16),
//                         child: Column(
//                           children: widgets,
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 14),
//                     child: PageViewDotIndicator(
//                       currentItem: selectedPage,
//                       count: (studies.length / 2).ceil(),
//                       unselectedColor: AppColors.gray150,
//                       selectedColor: AppColors.gray700,
//                       boxShape: BoxShape.circle,
//                       size: const Size(5, 5),
//                       unselectedSize: const Size(5, 5),
//                       duration: const Duration(milliseconds: 200),
//                       onItemClicked: (index) {
//                         _pageController.animateToPage(
//                           index,
//                           duration: const Duration(milliseconds: 200),
//                           curve: Curves.easeInOut,
//                         );
//                       },
//                     )),
//                 const SizedBox(height: 4),
//               ],
//             ),
//           )
//         : Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: 159,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 color: AppColors.gray50,
//               ),
//               child: const Center(
//                 child: Text(
//                   '해당 날짜에는\n등록된 일정이 없어요.',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       color: AppColors.gray300,
//                       fontWeight: AppFonts.fontWeight500),
//                 ),
//               ),
//             ),
//           );
//   }
// }
//
// class HomeStudyNotificationPageViewItem extends StatelessWidget {
//   final String studyName;
//   final String studyExplain;
//   final String startTime;
//
//   const HomeStudyNotificationPageViewItem(
//       this.studyName, this.studyExplain, this.startTime,
//       {super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: 66,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         color: AppColors.gray50,
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               startTime.replaceAll('00:00', '00'),
//               style: const TextStyle(
//                 color: AppColors.gray400,
//                 fontWeight: AppFonts.fontWeight600,
//                 fontSize: 14,
//               ),
//             ),
//             const SizedBox(width: 10),
//             const VerticalDivider(
//                 thickness: 1.5, width: 10, color: AppColors.gray100),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     studyName,
//                     style: const TextStyle(
//                       color: AppColors.blue500,
//                       fontWeight: AppFonts.fontWeight600,
//                       fontSize: 14,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   Text(
//                     studyExplain,
//                     style: const TextStyle(
//                       color: AppColors.gray800,
//                       fontWeight: AppFonts.fontWeight500,
//                       fontSize: 14,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
