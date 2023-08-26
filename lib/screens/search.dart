import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:withing/components/search_box.dart';

import '../components/category_selector.dart';
import '../components/study_list.dart';
import '../components/study_list_header.dart';

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
