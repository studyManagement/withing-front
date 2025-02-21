import 'dart:io';
import 'package:flutter/material.dart';
import 'package:modi/common/components/button/circle_button.dart';
import 'package:modi/common/components/button/label_circle_button.dart';
import '../../../common/components/gray_container.dart';
import '../../../common/theme/app/app_colors.dart';

class PostImageListView extends StatelessWidget {
  final List<String> imagePathList;
  final Function(int index)? onRemove;

  const PostImageListView(
      {super.key, required this.imagePathList, this.onRemove});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: imagePathList.length,
      itemBuilder: (context, index) {
        final imagePath = imagePathList[index];
        bool isNetworkImage = Uri.parse(imagePathList[index])
            .isAbsolute; // Check if the image is a network URL
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
                  child: isNetworkImage
                      ? Image.network(
                          imagePath,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Container(
                                color: AppColors.gray150,
                                child: Center(
                                    child: Transform.scale(
                                  scale: 0.6,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: AppColors.gray600,
                                  ),
                                )),
                              );
                            }
                          },
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Container(color: AppColors.gray150);
                          },
                        )
                      : (File(imagePath).existsSync()
                          // If it's a local file image
                          ? Image.file(
                              File(imagePath),
                              fit: BoxFit.cover,
                            )
                          : Container(
                              color: AppColors
                                  .gray150, // Placeholder for invalid paths
                            )),
                ),
              ),
              if (onRemove != null)
                Positioned(
                  top: 8,
                  right: 8,
                    child: CircleButton(
                  onTap: () => onRemove!(index),
                  image: Image.asset('asset/board/delete.png', width: 24, height: 24),
                )),
            ],
          ),
        );
      },
    );
  }
}
