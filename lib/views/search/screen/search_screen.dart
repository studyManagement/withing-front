import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/search_widget_resources.dart';
import '../../../di/injection.dart';
import '../../../data/data_resources.dart';
import '../../../view_models/search/search_viewmodel.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(getIt<CategorySearchRepository>()),
      child: Scaffold(
          body: SafeArea(
            child: Column(
              children: [
                SearchBox(),
                CategorySelector(),
                Gray50Divider(dividerHeight: 6),
                Gray50Divider(dividerHeight: 6),
                SizedBox(height: 10),
                StudyListHeader(),
                StudyList(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.push('/studies/new');
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(999),
            ),
            child: Icon(
              Icons.add,
              size: 32.0,
              color: Theme.of(context).colorScheme.background,
            ),
          )),
    );
  }
}
