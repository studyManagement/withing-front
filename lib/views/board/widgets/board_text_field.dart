import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';

import '../../../common/theme/app/app_colors.dart';

enum BoardInputType { boardTitle, boardContents, comment }

class BoardTextField extends StatefulWidget {
  final BoardInputType type;
  final bool isNew;
  final BoardViewModel viewModel;

  const BoardTextField(
      {super.key,
      required this.type,
      required this.isNew,
      required this.viewModel});

  @override
  State<BoardTextField> createState() => _BoardTextFieldState();
}

class _BoardTextFieldState extends State<BoardTextField> {
  late TextEditingController controller;
  late String? initValue;
  late bool isTitle;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    isTitle = (widget.type == BoardInputType.boardTitle) ? true : false;
    initValue = widget.isNew
        ? null
        : isTitle
            ? widget.viewModel.post!.title
            : widget.viewModel.post!.content;
    controller = TextEditingController(text: initValue);
  }

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = (isTitle)
        ? Theme.of(context).textTheme.titleSmall
        : Theme.of(context).textTheme.bodySmall;

    return TextFormField(
      controller: controller,
      onChanged: (value) {
        widget.viewModel.isValidInput(widget.type, value);
      },
      onEditingComplete: () {
        if (widget.viewModel.isValid) {
          (widget.type == BoardInputType.comment)
              ? {widget.viewModel.createComment(widget.viewModel.post!.id)}
              : (widget.isNew)
                  ? widget.viewModel.createPost()
                  : widget.viewModel.updatePost(widget.viewModel.post!.id);
          if (widget.type != BoardInputType.comment) {
            context.pop();
            widget.viewModel.refreshBoardList();
          } else {
            setState(() {
              controller.clear();
            });
          }
        }
      },
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: textStyle,
      maxLines: null,
      decoration: InputDecoration(
        filled: (widget.type == BoardInputType.comment) ? true : false,
        fillColor: AppColors.gray50,
        hintText: widget.viewModel.getHintText(widget.type),
        hintStyle: textStyle!
            .copyWith(color: AppColors.gray200, fontWeight: FontWeight.w500),
        contentPadding: const EdgeInsets.only(left: 20.0),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    );
  }
}
