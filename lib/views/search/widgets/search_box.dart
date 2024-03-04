import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/layout/responsive_size.dart';

class SearchBox extends StatelessWidget {
  const SearchBox({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    bool isTabletPrt = (screenWidth >= tabletPortrait) ? true : false;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 16, vertical: (isTabletPrt) ? screenWidth * 0.03 : 10),
      child: GestureDetector(
        onTap: () {
          context.push('/search/result');
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 32,
          height: 37,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).canvasColor,
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(
                Icons.search,
                color: Theme.of(context).hintColor,
              ),
              const SizedBox(width: 8),
              Text(
                '스터디 이름을 검색해보세요.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
