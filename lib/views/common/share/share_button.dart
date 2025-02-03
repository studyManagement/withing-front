import 'package:flutter/material.dart';
import '../../../common/components/share/share.dart';
import '../../../common/modal/modi_modal.dart';

Widget makeShareButton(BuildContext context,
    {required String title,
    required String message,
    required String path,
    required String contentType,
    required String itemId}) {
  return IconButton(
    onPressed: () {
      ModiModal.openBottomSheet(
        context,
        widget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
          child: Share(
            title: title,
            message: message,
            path: path,
            contentType: contentType,
            itemId: itemId,
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        height: 221,
      );
    },
    icon: Image.asset('asset/share.png'),
  );
}
