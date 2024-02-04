import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/common/components/automated_study_list_view.dart';
import '../../../di/injection.dart';
import '../../../service/search/category_search_service.dart';
import '../../../view_models/search/category_search_viewmodel.dart';
import '../../../common/components/gray50_divider.dart';
import '../widgets/_search_widget_resources.dart';

class CategorySearchScreen extends StatelessWidget {
  const CategorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CategorySearchViewModel(getIt<CategorySearchService>()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SearchBox(),
              SearchCategorySelector(),
              const Gray50Divider(dividerHeight: 6),
              const SizedBox(height: 16),
              Consumer<CategorySearchViewModel>(
                builder: (context, viewModel, child) {
                  return StudyListHeader(viewModel: viewModel);
                },
              ),
              Consumer<CategorySearchViewModel>(
                builder: (context, viewModel, child) {
                  return AutomatedStudyListView(viewModel: viewModel);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: const CreateStudyButton(),
      ),
    );
  }
}
