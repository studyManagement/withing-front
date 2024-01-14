import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:withing/view_models/search/search_viewmodel.dart';
import 'package:withing/views/search/widgets/search_widget_resources.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchViewModel(),
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
