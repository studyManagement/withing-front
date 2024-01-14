import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/search_widget_resources.dart';
import '../../../di/injection.dart';
import '../../../data/repository/category_search_repository.dart';
import '../../../view_models/search/search_viewmodel.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(getIt<CategorySearchRepository>()),
      child: Scaffold(
        appBar: SearchAppBar(
          controller: _controller,
          focusNode: _focusNode,
        ),
        body: const SafeArea(
          child: Column(
            children: [
              SizedBox(height: 10),
              StudyListHeader(),
              StudyList(),
            ],
          ),
        ),
      ),
    );
  }
}
