import 'package:flutter/material.dart';
import 'package:withing/screens/search/search_box.dart';

import 'category_selector.dart';
import './study_list.dart';
import './study_list_header.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SearchBox(),
            const CategorySelector(),
            Container(color: const Color(0xFFF4F7FC), height: 6),
            const SizedBox(height: 10),
            const StudyListHeader(),
            const StudyList(),
          ],
        ),
      ),
    );
  }
}
