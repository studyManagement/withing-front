import 'package:flutter/widgets.dart';

import '../../views/board/widgets/board_text_field.dart';
import '../../views/board/widgets/custom_tag_controller.dart';

class BoardInputViewModel extends ChangeNotifier{
  final TextEditingController titleController;
  final CustomTagController mentionableController;
  final bool isMember;

  BoardInputViewModel({String? initTitle, String? initContent, required this.isMember})
      : titleController = TextEditingController(text: initTitle ?? ''),
        mentionableController = CustomTagController(text: initContent ?? '');


  String getHintText(BoardInputType type) {
    switch (type) {
      case BoardInputType.boardTitle:
        return '제목';
      case BoardInputType.boardContents:
        return '내용을 입력해주세요.';
      case BoardInputType.comment:
        return (isMember) ? '댓글을 남겨주세요.' : '스터디 멤버만 댓글을 남길 수 있어요.';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    mentionableController.dispose();
    super.dispose();
  }
}
