import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../di/injection.dart';
import '../../../service/search/category_search_service.dart';
import '../../../view_models/search_study/search_study_viewmodel.dart';
import '../widgets/_search_widget_resources.dart';

class KeywordSearchScreen extends StatelessWidget {
  KeywordSearchScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchStudyViewModel(getIt<CategorySearchService>()),
      child: Scaffold(
        appBar: SearchAppBar(
          controller: _controller,
          focusNode: _focusNode,
        ),
        body: const SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              StudyListHeader(type: SearchType.keyword),
              StudyList(),
            ],
          ),
        ),
      ),
    );
  }
}
