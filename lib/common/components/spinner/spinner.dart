import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class Spinner extends StatefulWidget {
  const Spinner({
    required this.children,
    required this.width,
    required this.height,
    required this.initialValue,
    required this.onChanged,
    required this.selectItem,
    super.key,
  });

  final List<String> children;
  final double height;
  final double width;
  final String initialValue;
  final Function(int, String) onChanged;
  final int selectItem;

  @override
  State<StatefulWidget> createState() => _SpinnerState();
}

class _SpinnerState extends State<Spinner> {
  late FixedExtentScrollController _controller;
  late ValueNotifier<int> _pickedIndex;

  @override
  void initState() {
    super.initState();
    int initialIndex = widget.children.indexOf(widget.initialValue);
    _controller = FixedExtentScrollController(initialItem: initialIndex);
    _pickedIndex = ValueNotifier(initialIndex);
  }

  @override
  void didUpdateWidget(Spinner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectItem != widget.selectItem && oldWidget.initialValue != widget.initialValue) {
      setState(() {
        _controller.animateToItem(
          widget.children.indexOf(widget.initialValue),
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _pickedIndex,
      builder: (context, value, child) {
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: ListWheelScrollView(
            onSelectedItemChanged: (int i) {
              HapticFeedback.lightImpact();
              _pickedIndex.value = i;
              widget.onChanged(i, widget.children[i]);
            },
            offAxisFraction: 0,
            controller: _controller,
            squeeze: 1,
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.00001,
            itemExtent: 40,
            children: List.generate(
              widget.children.length,
              (index) => makeTextWidget(
                widget.children[index],
                _pickedIndex.value == index
                    ? AppColors.blue400
                    : AppColors.gray300,
              ),
            ),
          ),
        );
      },
    );
  }

  Text makeTextWidget(dynamic e, Color fontColor) {
    return Text(
      e.toString(),
      style: TextStyle(
        color: fontColor,
        fontWeight: AppFonts.fontWeight600,
        fontSize: 18,
      ),
    );
  }
}
