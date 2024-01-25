import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/modal/withing_modal.dart';
import '../../../common/theme/app/app_colors.dart';
import '../widgets/board_appbar.dart';

class CreatePostScreen extends StatefulWidget {
  final int studyId;
  bool isValid = false;
  String? title, content;

  CreatePostScreen({super.key, required this.studyId});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: boardAppBar(
          context,
          '',
          () => {
                WithingModal.openDialog(
                    context,
                    '글 작성을 취소하시겠어요?',
                    '페이지를 벗어나면\n입력된 내용이 모두 사라져요.',
                    true,
                    () => context.go('/studies/${widget.studyId}/board'),
                    null)
              },
          TextButton(
            onPressed: () {
              print("제목: ${widget.title}\n내용:${widget.content}");
            },
            child: Text("등록",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: (widget.isValid)
                        ? AppColors.blue400
                        : AppColors.gray300,
                    fontSize: 16)),
          )),
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                widget.title = value;
                if (value.isNotEmpty &&
                    widget.content != null &&
                    widget.content!.isNotEmpty) {
                  setState(() {
                    widget.isValid = true;
                  });
                } else {
                  setState(() {
                    widget.isValid = false;
                  });
                }
              },
              autofocus: false,
              cursorHeight: 20,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.titleSmall,
              decoration: InputDecoration(
                hintText: '제목',
                hintStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: AppColors.gray200, fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.only(left: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            const Divider(
              color: AppColors.gray100,
            ),
            TextField(
              onChanged: (value) {
                widget.content = value;
                if (value.isNotEmpty &&
                    widget.title != null &&
                    widget.title!.isNotEmpty) {
                  setState(() {
                    widget.isValid = true;
                  });
                } else {
                  setState(() {
                    widget.isValid = false;
                  });
                }
              },
              autofocus: false,
              cursorHeight: 20,
              keyboardType: TextInputType.text,
              style: Theme.of(context).textTheme.bodySmall,
              decoration: InputDecoration(
                hintText: '내용을 입력해주세요.',
                hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.gray200, fontWeight: FontWeight.w500),
                contentPadding: const EdgeInsets.only(left: 20.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
