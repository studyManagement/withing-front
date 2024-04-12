import 'package:flutter/material.dart';

class BottomShadow extends StatelessWidget {
  Widget child;
  double? elevation;
  Color? shadowColor;

  BottomShadow({super.key, required this.child, this.elevation, this.shadowColor});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        elevation: elevation ?? 10.0,
        shadowColor: (shadowColor) ?? const Color.fromARGB(40, 0, 0, 0),
        color: Colors.white,
        surfaceTintColor: Colors.white,
        child: child);
  }
}
