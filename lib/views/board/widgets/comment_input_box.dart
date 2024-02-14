import 'package:flutter/material.dart';
import 'package:modi/views/board/widgets/board_text_field.dart';
import '../../../view_models/board/board_viewmodel.dart';

class CommentInputBox extends StatelessWidget{
  final BoardViewModel viewModel;
  const CommentInputBox({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context){
    return Container(
      height:94,
      padding: const EdgeInsets.symmetric(vertical:10,horizontal:16),
      child: BoardTextField(type: BoardInputType.comment,viewModel: viewModel, isNew: true
      ),
    );
  }
}