import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/components/automated_study_list_view.dart';
import '../../../di/injection.dart';
import '../../../service/search/keyword_search_service.dart';
import '../../../view_models/search/keyword_search_viewmodel.dart';
import '../widgets/_search_widget_resources.dart';

class KeywordSearchScreen extends StatelessWidget {
  KeywordSearchScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KeywordSearchViewModel(getIt<KeywordSearchService>()),
      child: Scaffold(
        appBar: const SearchAppBar(),
        body: SafeArea(
          child: Column(
            children: [
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
