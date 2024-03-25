import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              image: const DecorationImage(
                  image: AssetImage('asset/default_image.png'))),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: Image.asset(
            'asset/camera.png',
            width: 32,
            height: 32,
          ),
        ),
      ],
    );
  }
}
