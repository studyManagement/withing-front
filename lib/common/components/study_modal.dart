import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modal_button.dart';

class StudyModal extends StatelessWidget {
  final String title;
  final String content;
  final ModalButton button1;
  final ModalButton button2;

  const StudyModal(
      {super.key,
      required this.title,
      required this.content,
      required this.button1,
        required this.button2});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding:
          const EdgeInsets.only(left: 12, right: 12, top: 27, bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
        textAlign: TextAlign.center,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      content: SizedBox(
        width: 291,
        height: 40,
        child: Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ),
      actionsPadding:
          const EdgeInsets.only(left: 12, right: 12, top: 16, bottom: 12),
      actions: <Widget>[
        Row(
          children: [
            button1,
            const SizedBox(width:5),
            button2,
          ],
        ),
      ],
    );
  }
}
