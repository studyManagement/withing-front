import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class CommentInputBox extends StatelessWidget{
  const CommentInputBox({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      height:94,
      padding: const EdgeInsets.symmetric(vertical:10,horizontal:16),
      child: TextField(
        autofocus: false,
        cursorHeight: 20,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.gray50,
          hintText: '댓글을 남겨주세요.',
          hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.gray300),
          contentPadding: const EdgeInsets.only(left: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    );
  }
}