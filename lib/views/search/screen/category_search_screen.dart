import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../service/search/category_search_service.dart';
import '../../../service/search/keyword_search_service.dart';
import '../../../view_models/search/search_study_viewmodel.dart';
import '../../../common/components/gray50_divider.dart';
import '../widgets/_search_widget_resources.dart';

class CategorySearchScreen extends StatelessWidget {
  const CategorySearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchStudyViewModel(
        getIt<CategorySearchService>(),
        getIt<KeywordSearchService>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const SearchBox(),
              SearchCategorySelector(),
              const Gray50Divider(dividerHeight: 6),
              const SizedBox(height: 16),
              const StudyListHeader(type: SearchType.category),
              SearchedStudyList(SearchType.category),
            ],
          ),
        ),
        floatingActionButton: const CreateStudyButton(),
      ),
    );
  }
}
