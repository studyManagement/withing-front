import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/view_models/board/board_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../common/modal/withing_modal.dart';
import '../../../common/theme/app/app_colors.dart';

enum BoardInputType { boardTitle, boardContents, comment }

class BoardTextField extends StatefulWidget {
  final BoardInputType type;
  String? initValue;

  BoardTextField({super.key, required this.type, this.initValue});

  @override
  State<BoardTextField> createState() => _BoardTextFieldState();
}

class _BoardTextFieldState extends State<BoardTextField> {
  TextEditingController controller = TextEditingController();


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BoardViewModel vm = Provider.of<BoardViewModel>(context);

    bool isTitle = (widget.type == BoardInputType.boardTitle) ? true : false;
    bool isNew = (widget.initValue == null && widget.type != BoardInputType.comment);
    TextStyle? textStyle = (isTitle)
        ? Theme.of(context).textTheme.titleSmall
        : Theme.of(context).textTheme.bodySmall;

    return TextFormField(
      controller: controller,
      onChanged: (value) {
        vm.isValidInput(widget.type, value);
      },
      initialValue: widget.initValue,
      onEditingComplete: () {
        (widget.type == BoardInputType.comment)
            ? {vm.createComment(vm.post!.id)}
            : (isNew)
                ? vm.createPost()
                : vm.updatePost(vm.post!.id);
        if (widget.type != BoardInputType.comment) {
          WithingModal.openDialog(context, vm.getNoticeTitle(isNew),
              vm.getNoticeContents(isNew), false, () {
            context
              ..pop()
              ..pop();
          }, () => null);
        }
        setState(() {
          controller.clear();
        });
      },
      autofocus: false,
      cursorHeight: 20,
      keyboardType: TextInputType.text,
      style: textStyle,
      maxLines: null,
      decoration: InputDecoration(
        filled: (widget.type == BoardInputType.comment) ? true : false,
        fillColor: AppColors.gray50,
        hintText: vm.getHintText(widget.type),
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
