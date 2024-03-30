import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../common/layout/responsive_size.dart';
import '../../../view_models/search/keyword_search_viewmodel.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({
    super.key,
  });

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _SearchAppBarState extends State<SearchAppBar> {
  Timer? debounce;

  @override
  void dispose(){
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<KeywordSearchViewModel>(context);
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: Colors.transparent,
      leadingWidth: 60.0,
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: SizedBox(
          height: 37.0,
          child: TextField(
            autofocus: true,
            onSubmitted: (String value) {
              if (value != '') viewModel.searchKeyword = value;
              viewModel.search();
            },
            onChanged: (String value){
              viewModel.searchKeyword = value;
              if (debounce?.isActive ?? false){
                debounce?.cancel();
              }
              debounce = Timer(const Duration(milliseconds: 300), () {
                  viewModel.search();
                });
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
