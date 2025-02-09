import 'package:flutter/material.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';

class PostCategorySelector extends StatelessWidget {
  final List<PostCategory> postCategories;
  final int selectedIndex;

  const PostCategorySelector(
      {super.key, required this.postCategories, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BoardViewModel>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        children: postCategories
            .map((e) => _PostCategoryTag(
                title: e.name,
                iconPath:
                    e.id == -1 ? null : e.id == selectedIndex ? e.activeIcon : e.inactiveIcon,
                onTap: () {
                  viewModel.updateSelectedCategory(e.id);
                },
                isSelected: e.id == selectedIndex))
            .toList(),
      ),
    );
  }
}

class _PostCategoryTag extends StatelessWidget {
  final String title;
  String? iconPath;
  final Function()? onTap;
  final bool isSelected;
  final bool isNew;

  _PostCategoryTag(
      {required this.title,
      this.iconPath,
      required this.onTap,
      this.isSelected = false,
      this.isNew = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Container(
            height: 36,
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: 1.20,
                    color: isSelected ? AppColors.blue300 : AppColors.gray200),
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (iconPath != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Image.asset(iconPath!),
                  ),
                Text(title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: isSelected
                            ? AppColors.gray900
                            : AppColors.gray400)),
              ],
            ),
          ),
          if (isNew)
            Positioned(
                right: 10,
                top: 11,
                child: Image.asset(
                  'asset/board/new_badge.png',
                  width: 4,
                  height: 4,
                ))
        ],
      ),
    );
  }
}
