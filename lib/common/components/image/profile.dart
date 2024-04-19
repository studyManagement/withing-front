import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final ShapeDecoration shapeDecoration;
  final Function()? onTap;
  final String bottomImagePath;

  const Profile(
      {super.key,
      required this.shapeDecoration,
      this.onTap,
      required this.bottomImagePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: Container(
            width: 105,
            height: 105,
            decoration: shapeDecoration,
            alignment: Alignment.bottomRight,
            child: Image.asset(
              bottomImagePath,
              width: 32,
              height: 32,
            )),
      ),
    );
  }
}
