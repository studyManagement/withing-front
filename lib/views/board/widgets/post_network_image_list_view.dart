import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class PostNetworkImageListView extends StatelessWidget {
  final List<String> imageUrls;

  const PostNetworkImageListView({
    super.key,
    required this.imageUrls,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemCount: imageUrls.length,
      itemBuilder: (context, index) {
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
                  child: Image.network(
                    imageUrls[index],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return _loadingIndicator();
                    },
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: AppColors.gray150),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _loadingIndicator() {
    return Container(
      color: AppColors.gray150,
      child: Center(
        child: Transform.scale(
          scale: 0.6,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.gray600,
          ),
        ),
      ),
    );
  }
}
