import 'package:modi/common/sns_content_share/sns_content_share.dart';
import 'package:share_plus/share_plus.dart';

class OSShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    await Share.share("$title\n$content");
    return;
  }
}
