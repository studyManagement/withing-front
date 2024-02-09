import 'package:flutter/material.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import '../../../common/theme/app/app_colors.dart';

class CommentInputBox extends StatelessWidget{
  const CommentInputBox({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      height:94,
      padding: const EdgeInsets.symmetric(vertical:10,horizontal:16),
      child: BoardTextField(type: BoardInputType.comment,
      ),
    );
  }
}