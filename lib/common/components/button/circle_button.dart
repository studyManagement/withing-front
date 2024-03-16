import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function()? onTap;
  final Image? image;
  final Icon? icon;

  const CircleButton({
    Key? key,
    required this.onTap,
    this.image,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(!(image != null && icon != null), 'image와 icon은 동시에 설정할 수 없습니다.');

    return GestureDetector(
      onTap: onTap,
      child: (image == null) ? icon : image,
    );
  }
}
