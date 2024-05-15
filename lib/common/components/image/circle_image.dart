import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class CircleImage extends StatelessWidget {
  double width;
  double height;
  Image? image;
  Icon? icon;
  Function()? onTap;

  @override
  Widget build(BuildContext context) {
    assert(
        !(icon != null && image != null), 'icon 속성과 image 속성은 동시에 선언할 수 없습니다.');
    return GestureDetector(
        onTap: onTap,
        child: (image == null && icon == null)
            ? Container(
                width: width,
                height: height,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.asset('asset/default_image.png'))
            : (image == null)
                ? Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: AppColors.gray150,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  )
                : Container(
                    width: width,
                    height: height,
                    decoration: const BoxDecoration(
                      color: AppColors.gray150,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: image,
                    ),
                  ));
  }

  CircleImage(this.width, this.height,
      {super.key, this.image, this.icon, this.onTap});
}
