import 'package:flutter/material.dart';

class Gray100Divider extends StatelessWidget {
  const Gray100Divider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        color: Theme.of(context).canvasColor,
        height: 1.0,
      ),
    );
  }
}
