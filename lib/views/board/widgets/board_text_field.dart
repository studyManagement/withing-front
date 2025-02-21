import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/view_models/board/board_input_viewmodel.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/theme/app/app_colors.dart';
import '../screen/board_info_screen.dart';

enum BoardInputType { boardTitle, boardContents, comment }

class BoardTextField extends StatelessWidget {
  final Function(String) onChanged;
  final Function() onEditingCompleted;

  const BoardTextField(
      {super.key,
      required this.onChanged,
      required this.onEditingCompleted});

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleLarge;
    final viewModel = context.read<BoardInputViewModel>();
    return TextFormField(
      controller: viewModel.titleController,
      onChanged: (value) {
        onChanged(value);
      },
      onEditingComplete: () {
        onEditingCompleted();
      },
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: textStyle,
      maxLines: null,
      decoration: InputDecoration(
        filled: false,
        fillColor: AppColors.gray50,
        hintText: viewModel.getHintText(BoardInputType.boardTitle),
        hintStyle: textStyle!
            .copyWith(color: AppColors.gray300, fontWeight: FontWeight.w600),
        contentPadding: const EdgeInsets.only(left: 16, top: 20, bottom: 20),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
