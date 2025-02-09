import 'package:flutter/material.dart';
import 'package:modi/view_models/board/board_input_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../common/theme/app/app_colors.dart';
import 'board_text_field.dart';

class MentionableTextField extends StatelessWidget {
  final BoardInputType type;
  final Function(String) onChanged;
  final Function() onEditingCompleted;

  const MentionableTextField({
    super.key,
    required this.type,
    required this.onChanged,
    required this.onEditingCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<BoardInputViewModel>();
    TextStyle? textStyle = Theme.of(context).textTheme.bodySmall;
    bool isComment = (type == BoardInputType.comment) ? true : false;

    return TextFormField(
      enabled: (isComment && !viewModel.isMember) ? false : true,
      controller: viewModel.mentionableController,
      onChanged: (value) {
        onChanged(value);
        print(viewModel.mentionableController.getTextToWordArr());
      },
      onEditingComplete: () {
        onEditingCompleted();
        if (isComment) {
          viewModel.mentionableController.clear();
        }
      },
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: textStyle,
      maxLines: null,
      decoration: InputDecoration(
        filled: (isComment) ? true : false,
        fillColor: AppColors.gray50,
        hintText: viewModel.getHintText(isComment ? BoardInputType.comment : BoardInputType.boardContents),
        hintStyle: textStyle!
            .copyWith(color: AppColors.gray300, fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.only(left: 20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
