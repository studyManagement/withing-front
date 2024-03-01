import 'package:flutter/services.dart';
import 'package:modi/common/sns_content_share/sns_content_share.dart';

class ClipboardShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    Clipboard.setData(ClipboardData(text: '$title\n$content'));
    return;
  }
}
