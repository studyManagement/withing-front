import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../service/search/category_search_service.dart';
import '../../../service/search/keyword_search_service.dart';
import '../../../view_models/search/search_study_viewmodel.dart';
import '../widgets/_search_widget_resources.dart';

class KeywordSearchScreen extends StatelessWidget {
  KeywordSearchScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchStudyViewModel(
        getIt<CategorySearchService>(),
        getIt<KeywordSearchService>(),
      ),
      child: Scaffold(
        appBar: const SearchAppBar(),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 10),
              const StudyListHeader(type: SearchType.keyword),
              SearchedStudyList(SearchType.keyword),
            ],
          ),
        ),
      ),
    );
  }
}
