import 'package:flutter/material.dart';
import 'package:withing/common/theme/app/app_colors.dart';

class ModalButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final Color backgroundcolor;

  const ModalButton({
    Key? key,
    required this.onTap,
    required this.text,
    required this.backgroundcolor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
          onTap: onTap,
          child: Container(
            width: 143,
            height: 42,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8), color: backgroundcolor),
            child: Center(
              child: Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          )),
    );
  }
}
