import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view_models/search/search_study_viewmodel.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<SearchStudyViewModel>(context);

    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leadingWidth: 60.0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          height: 36.0,
          child: TextField(
            autofocus: true,
            onSubmitted: (String value) {
              if (value != '') viewModel.searchKeyword = value;
              viewModel.keywordSearch();
            },
            cursorHeight: 20,
            maxLength: 20,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              counterText: "",
              hintText: '스터디 이름을 검색해보세요.',
              hintStyle: Theme.of(context).textTheme.bodySmall,
              filled: true,
              fillColor: Theme.of(context).canvasColor,
              contentPadding: const EdgeInsets.only(left: 20.0),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
