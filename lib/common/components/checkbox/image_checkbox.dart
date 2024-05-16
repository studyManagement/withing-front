import 'package:flutter/widgets.dart';

class ImageCheckbox extends StatefulWidget {
  ImageCheckbox({super.key});

  @override
  State<StatefulWidget> createState() => _ImageCheckboxState();
}

class _ImageCheckboxState extends State<ImageCheckbox> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isChecked = !_isChecked;
        });
      },
      child: Image.asset(
        _isChecked
            ? 'assets/images/checkbox_checked.png'
            : 'assets/images/checkbox_unchecked.png',
      ),
    );
  }
}
