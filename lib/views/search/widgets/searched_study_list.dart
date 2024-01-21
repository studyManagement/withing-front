import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'gray100_divider.dart';
import 'package:withing/model/search/searched_study_info_model.dart';
import 'package:withing/view_models/create/create_study_viewmodel.dart';
import '../../../common/theme/app/app_colors.dart';
import '../../../common/theme/app/app_fonts.dart';
import '../../../common/components/study_categories_widget.dart';
import '../../../view_models/search/search_study_viewmodel.dart';

class SearchedStudyList extends StatelessWidget {
  final SearchType type;

  SearchedStudyList(this.type);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Expanded(
      child: Consumer<SearchStudyViewModel>(builder: (
        context,
        viewModel,
        child,
      ) {
        bool isCategoryType = type == SearchType.category;
        int studyCount = isCategoryType
            ? (viewModel.studyWithCategory?.length ?? 0)
            : (viewModel.studyWithKeyword?.length ?? 0);
        List<SearchedStudyInfo>? studies = isCategoryType
            ? viewModel.studyWithCategory
            : viewModel.studyWithKeyword;

        return NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (scrollInfo.metrics.pixels ==
                  scrollInfo.metrics.maxScrollExtent) {
                viewModel.scrollListener(type);
              }
              return true;
            },
            child: ListView.separated(
              controller: scrollController,
              itemCount: studyCount,
              itemBuilder: (context, index) =>
                  (index < studyCount) ? _StudyCard(studies![index]) : null,
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
        context.push('/studies/${info.studyId}');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          children: [
            _StudyHeader(info.studyName, info.studyImage),
            _StudyDetails(
              [
                ('참여 인원', '${info.headCount}/${info.max}'),
                (
                  '정기 모임',
                  '${convertDays(info.days, info.gap)} ${convertTime(info.startTime)}'
                ),
              ],
            ),
            StudyCategoriesWidget(
              categories: convertIndiciesToElements(info.categories),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudyHeader extends StatelessWidget {
  final String studyName;
  final String? studyImage;

  const _StudyHeader(this.studyName, this.studyImage);

  @override
  Widget build(BuildContext context) {
    ShapeDecoration shapeDecoration = studyImage != null
        ? ShapeDecoration(
            shape: const OvalBorder(),
            image: DecorationImage(
              image: AssetImage(studyImage!),
              fit: BoxFit.cover,
            ),
          )
        : const ShapeDecoration(
            shape: OvalBorder(),
            color: AppColors.gray150,
          );

    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 38,
              height: 38,
              child: Container(decoration: shapeDecoration),
            ),
            const SizedBox(width: 12),
            Text(
              studyName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        const SizedBox(height: 10),
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
      widgets.add(
        const SizedBox(height: 12),
      );
    }

    return Column(children: widgets);
  }
}
