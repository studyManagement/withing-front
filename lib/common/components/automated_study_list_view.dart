import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/theme_resources.dart';
import '../../../common/components/gray100_divider.dart';
import '../../../common/components/study_categories_widget.dart';
import '../../../model/search/searched_study_info_model.dart';
import '../../../view_models/search/search_study_viewmodel.dart'; // 제거

class AutomatedStudyListView extends StatelessWidget {
  // final ViewModel viewModel;

  AutomatedStudyListView(
      // {required this.viewModel}
      );

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Expanded(
      // 주입받은 뷰모델로 대체
      child: Consumer<SearchStudyViewModel>(builder: (
        context,
        viewModel,
        child,
      ) {
        // 뷰모델에서 참조
        int searchesCount = 0; // viewModel.searchesCount
        List<SearchedStudyInfo>? studyList = []; // viewModel.studyList

        return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                // viewModel.scrollListener();
                /// scroll listener 예시 - 뷰모델에 정의
                //   Future<void> scrollListener() async {
                //     if (_isLoading) return;
                //     _isLoading = true;
                //
                //     fetchStudies();
                //
                //     _isLoading = false;
                //   }
              }
              return true;
            },
            child: ListView.separated(
              controller: scrollController,
              itemCount: searchesCount,
              itemBuilder: (context, index) =>
                  (index < searchesCount) ? _StudyCard(studyList[index]) : null,
              separatorBuilder: (context, index) => const Gray100Divider(),
            ));
      }),
    );
  }
}

class _StudyCard extends StatelessWidget {
  final SearchedStudyInfo info;

  const _StudyCard(this.info);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/studies/${info.id}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _StudyHeader(
              studyName: info.teamName ?? '',
              studyImageUrl: info.studyImage,
            ),
            _StudyDetails(
              [
                ('참여 인원', '${info.headcount}/${info.max}'),
                (
                  '정기 모임',
                  convertMeetingDetails(info.meetingSchedules),
                ),
              ],
            ),
            StudyCategoriesWidget(categories: info.categories),
          ],
        ),
      ),
    );
  }
}

class _StudyHeader extends StatelessWidget {
  final String studyName;
  final String? studyImageUrl;

  const _StudyHeader({
    required this.studyName,
    required this.studyImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    Container grayContainer =
        Container(width: 38, height: 38, color: AppColors.gray150);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipOval(
              child: (studyImageUrl != null)
                  ? Image.network(
                      studyImageUrl!,
                      width: 38,
                      height: 38,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace? stackTrace) {
                        return grayContainer;
                      },
                    )
                  : grayContainer,
            ),
            const SizedBox(width: 12),
            Text(
              studyName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _StudyDetails extends StatelessWidget {
  final List<(String, String)> studyDetails;

  const _StudyDetails(this.studyDetails);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var (title, content) in studyDetails) {
      widgets.add(
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: AppFonts.fontSize13,
                    color: AppColors.gray400,
                  ),
            ),
            const SizedBox(width: 8),
            Text(
              content,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: AppFonts.fontSize13,
                    color: AppColors.gray800,
                  ),
            )
          ],
        ),
      );
      widgets.add(const SizedBox(height: 4));
    }

    widgets.add(const SizedBox(height: 12));

    return Column(children: widgets);
  }
}
