import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/app/app_colors.dart';

class BottomToast {
  final BuildContext context;
  final String text;

  BottomToast({required this.context, required this.text});

  get fToast => FToast();

  void _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.blue400,
      ),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.white),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _closeToast();
            },
            child: const Icon(Icons.close, color: AppColors.white),
          ),
        ],
      ),
    );

    fToast.init(context).showToast(
      child: toast,
      toastDuration: const Duration(seconds: 2),
    );
  }

  void _closeToast() {
    fToast.removeCustomToast();
  }

  void show() {
    _showToast();
  }
}
