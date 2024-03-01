import 'package:flutter/material.dart';

class CircleButton extends StatelessWidget {
  final Function()? onTap;
  final Image image;

  const CircleButton({
    Key? key,
    required this.onTap,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: image,
    );
  }
}
