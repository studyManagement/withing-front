import 'package:flutter/material.dart';
import 'package:modi/view_models/board/model/post_category.dart';
import '../../../common/theme/app/app_colors.dart';

class PostCategorySelector extends StatelessWidget {
  final List<PostCategory> postCategories;
  final PostCategoryType selectedCategoryType;
  final Function(PostCategoryType category) onTap;

  const PostCategorySelector(
      {super.key,
      required this.postCategories,
      required this.selectedCategoryType,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Wrap(
        spacing: 8,
        direction: Axis.horizontal,
        children: postCategories
            .map((e) => _PostCategoryTag(
                key: ValueKey(e.type),
                title: e.name,
                iconPath: e.id == 0
                    ? null
                    : e.type == selectedCategoryType
                        ? e.activeIcon
                        : e.inactiveIcon,
                onTap: () => onTap(e.type),
                isSelected: e.type == selectedCategoryType))
            .toList(),
      ),
    );
  }
}

class _PostCategoryTag extends StatelessWidget {
  final String title;
  final String? iconPath;
  final Function()? onTap;
  final bool isSelected;
  final bool isNew;

  const _PostCategoryTag(
      {super.key,
      required this.title,
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
                    child: Image.asset(iconPath!, gaplessPlayback: true),
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
