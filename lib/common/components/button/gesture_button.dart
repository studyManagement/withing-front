import 'package:flutter/cupertino.dart';

class GestureButton extends StatelessWidget {
  final Widget _widget;
  final Function() _onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(child: _widget),
    );
  }

  GestureButton(this._widget, this._onTap, {super.key});
}
