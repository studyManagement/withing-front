import 'package:flutter/material.dart';

class Gray100Divider extends StatelessWidget {
  final double dividerHeight;

  const Gray100Divider({
    super.key,
    this.dividerHeight = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        height: dividerHeight,
      ),
    );
  }
}
