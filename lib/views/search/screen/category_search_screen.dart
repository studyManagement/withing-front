import 'package:flutter/material.dart';
import 'package:modi/common/components/automated_study_list_view.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:modi/common/layout/responsive_size.dart';
import 'package:provider/provider.dart';

import '../../../common/components/exception/modi_exception.dart';
import '../../../common/components/gray50_divider.dart';
import '../../../di/injection.dart';
import '../../../model/search/searched_study_info_model.dart';
import '../../../service/search/study_search_service.dart';
import '../../../view_models/search/category_search_viewmodel.dart';
import '../widgets/_search_widget_resources.dart';

class CategorySearchScreen extends StatelessWidget {
  const CategorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    bool isTabletPrt = MediaQuery.of(context).size.width >= tabletPortrait;
    double scrollableHeight = (isTabletPrt)
        ? MediaQuery.of(context).size.width
        : MediaQuery.of(context).size.height;

    return ChangeNotifierProvider(
        create: (_) => CategorySearchViewModel(getIt<StudySearchService>()),
        child: Consumer<CategorySearchViewModel>(
            builder: (context, viewModel, child) {
          List<SearchedStudyInfo> studyList = viewModel.studyList ?? [];
          int searchesCount = viewModel.studyList.length;
          print(searchesCount);
          return DefaultLayout(
            floatingActionButton: const CreateStudyButton(),
            child: SafeArea(
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels >=
                      scrollInfo.metrics.maxScrollExtent) {
                    viewModel.scrollListener();
                  }
                  return true;
                },
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: SizedBox(
                    height: (searchesCount == 0)
                        ? scrollableHeight * 0.85
                        : scrollableHeight + (searchesCount) * 150,
                    child: Column(
                      children: [
                        const SearchBox(),
                        const SearchCategorySelector(),
                        const Gray50Divider(dividerHeight: 6),
                        const SizedBox(height: 10),
                        StudyListHeader(viewModel: viewModel),
                        AutomatedStudyListView(viewModel: viewModel),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
