import 'package:flutter/material.dart';

class Gray50Divider extends StatelessWidget {
  final double dividerHeight;

  const Gray50Divider({
    super.key,
    this.dividerHeight = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).canvasColor,
      height: dividerHeight,
    );
  }
}
