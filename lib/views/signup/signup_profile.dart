import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Image image;
  final String bottomImagePath;
  const Profile({super.key, required this.image, required this.bottomImagePath});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: DecorationImage(
                  image: image.image)),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            bottomImagePath,
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
