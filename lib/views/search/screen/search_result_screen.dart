import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:withing/views/search/widgets/search_widget_resources.dart';

import '../../../view_models/search/search_viewmodel.dart';

class SearchResultScreen extends StatelessWidget {
  SearchResultScreen({super.key});

  final TextEditingController _controller = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
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
