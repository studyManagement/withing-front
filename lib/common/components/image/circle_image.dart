import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class CircleImage extends StatelessWidget {
  double width;
  double height;
  Image? image;

  @override
  Widget build(BuildContext context) {
    if (image == null) {
      return Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: AppColors.gray150,
          borderRadius: BorderRadius.all(Radius.circular(36)),
        ),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(36)),
      ),
      child: image,
    );
  }

  CircleImage(this.width, this.height, {super.key, this.image});
}
