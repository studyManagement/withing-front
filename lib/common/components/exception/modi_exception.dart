import 'package:flutter/cupertino.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class ModiException extends StatelessWidget {
  List<String> message;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset('asset/exclamation.png', width: 40, height: 40),
        const SizedBox(height: 10),
        ...message.map(
          (e) => Center(
            child: Text(
              e,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: AppFonts.fontWeight500,
                color: AppColors.gray300,
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  ModiException(this.message, {super.key});
}
