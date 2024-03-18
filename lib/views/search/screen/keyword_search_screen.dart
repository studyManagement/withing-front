import 'package:flutter/material.dart';
import 'package:modi/common/layout/default_layout.dart';
import 'package:provider/provider.dart';
import '../../../common/components/automated_study_list_view.dart';
import '../../../common/layout/responsive_size.dart';
import '../../../di/injection.dart';
import '../../../service/search/study_search_service.dart';
import '../../../view_models/search/keyword_search_viewmodel.dart';
import '../widgets/_search_widget_resources.dart';

class KeywordSearchScreen extends StatelessWidget {
  const KeywordSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTabletPrt = (screenWidth >= tabletPortrait) ? true : false;
    return ChangeNotifierProvider(
      create: (_) => KeywordSearchViewModel(getIt<StudySearchService>()),
      child: DefaultLayout(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: (isTabletPrt) ? screenWidth * 0.023 : 0),
              const SearchAppBar(),
              const SizedBox(height: 10),
              Consumer<KeywordSearchViewModel>(
                builder: (context, viewModel, child) {
                  return StudyListHeader(viewModel: viewModel);
                },
              ),
              Consumer<KeywordSearchViewModel>(
                builder: (context, viewModel, child) {
                  return AutomatedStudyListView(viewModel: viewModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
