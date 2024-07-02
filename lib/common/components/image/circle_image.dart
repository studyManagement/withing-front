import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';

class CircleImage extends StatelessWidget {
  CircleImage({super.key, required this.size, this.image, this.icon, this.onTap});
  double size;
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
                width: size,
                height: size,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.blue100
                ),
          child:  Image.asset('asset/search_category/2_certification.png'),
        )
            : (image == null)
                ? Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      color: AppColors.gray150,
                      shape: BoxShape.circle,
                    ),
                    child: icon,
                  )
                : Container(
                    width: size,
                    height: size,
                    decoration: const BoxDecoration(
                      color: AppColors.blue100,
                      shape: BoxShape.circle,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(360),
                      child: image,
                    ),
                  ));
  }

}
