import 'package:modi/common/sns_content_share/sns_content_share.dart';
import 'package:social_share/social_share.dart';

class TwitterShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    await SocialShare.shareTwitter("$title\n\n$content");
    return;
  }
}
