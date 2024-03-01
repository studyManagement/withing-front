import 'package:modi/common/sns_content_share/sns_content_share.dart';
import 'package:social_share/social_share.dart';

class SmsShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    await SocialShare.shareSms("$title\n\n$content");
    return;
  }
}
