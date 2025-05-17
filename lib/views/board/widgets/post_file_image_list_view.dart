import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/components/button/circle_button.dart';
import '../../../common/theme/app/app_colors.dart';

class PostFileImageListView extends StatelessWidget {
  final Function(int index) onRemove;

  const PostFileImageListView({
    super.key,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
     final vm = context.watch<BoardViewModel>();
     final files = vm.imageFiles;

    return vm.imageFiles.isEmpty ? const SizedBox.shrink() : SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: files.length,
        itemBuilder: (context, index) {
          final file = files[index];
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: ShapeDecoration(
                    color: AppColors.gray100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      file,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(color: AppColors.gray150),
                    ),
                  ),
                ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: CircleButton(
                      onTap: () => onRemove(index),
                      image: Image.asset(
                        'asset/board/delete.png',
                        width: 24,
                        height: 24,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

Widget _loadingIndicator() {
  return Center(
    child: Transform.scale(
      scale: 0.6,
      child: const CircularProgressIndicator(
        strokeWidth: 2,
        color: AppColors.gray600,
      ),
    ),
  );
}