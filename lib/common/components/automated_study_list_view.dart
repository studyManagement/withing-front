import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/components/image/circle_image.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/theme_resources.dart';
import '../../../common/components/gray100_divider.dart';
import '../../../common/components/study_categories_widget.dart';
import '../../../model/search/searched_study_info_model.dart';
import '../../view_models/search/searched_studies_viewmodel.dart';
import '../utils/get_regular_meeting_string.dart';
import 'exception/modi_exception.dart';

class AutomatedStudyListView extends StatelessWidget {
  final SearchedStudiesViewModel viewModel;
  final ScrollController? scrollController;

  const AutomatedStudyListView(
      {super.key, required this.viewModel, this.scrollController});

  @override
  Widget build(BuildContext context) {
    int searchesCount = viewModel.studyList?.length ?? 0;
    List<SearchedStudyInfo> studyList = viewModel.studyList ?? [];

    return Expanded(
        child: (viewModel.isInitLoading)
            ? const Center(child: CircularProgressIndicator())
            : studyList.isEmpty
                ? ModiException(['등록된 스터디가 없어요.'])
                : NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification scrollInfo) {
                      if (scrollInfo.metrics.pixels >=
                          scrollInfo.metrics.maxScrollExtent) {
                        viewModel.scrollListener();
                      }
                      return true;
                    },
                    child: ListView.separated(
                      controller:
                          (scrollController == null) ? null : scrollController,
                      physics: (scrollController == null)
                          ? NeverScrollableScrollPhysics()
                          : null,
                      itemCount: searchesCount,
                      itemBuilder: (context, index) => (index < searchesCount)
                          ? _StudyCard(
                              info: studyList[index],
                              onTap: () => context.push(
                                  '/studies/${studyList[index].id}'))
                          : null,
                      separatorBuilder: (context, index) =>
                          const Gray100Divider(),
                    ),
                  ));
  }
}

class _StudyCard extends StatelessWidget {
  final SearchedStudyInfo info;
  final Function() onTap;

  const _StudyCard({required this.info, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _StudyHeader(
              studyName: info.studyName ?? '',
              studyImageUrl: info.studyImage,
              isPrivate: info.private,
            ),
            _StudyDetails(
              [
                ('참여 인원', '${info.headcount}/${info.max}'),
                ('정기 모임', getRegularMeetingString(info.meetingSchedules)),
              ],
            ),
            if (info.categories.every((e) => e.isNotEmpty))
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
  final bool isPrivate;

  const _StudyHeader({
    required this.studyName,
    required this.studyImageUrl,
    required this.isPrivate,
  });

  @override
  Widget build(BuildContext context) {
    Container grayContainer =
        Container(width: 38, height: 38, color: AppColors.gray150);

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleImage(
                size: 38,
                image: (studyImageUrl == null)
                    ? null
                    : Image.network(
                        studyImageUrl!,
                        width: 38,
                        height: 38,
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace? stackTrace) {
                          return grayContainer;
                        },
                      )),
            const SizedBox(width: 8),
            Row(
              children: [
                if (isPrivate)
                  Image.asset(
                    'asset/lock_20.png',
                    width: 20,
                    height: 20,
                  ),
                if (isPrivate) const SizedBox(width: 6),
                Text(
                  studyName,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
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
          crossAxisAlignment: CrossAxisAlignment.start,
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
