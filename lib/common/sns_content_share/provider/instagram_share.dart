import 'package:modi/common/sns_content_share/sns_content_share.dart';
import 'package:url_launcher/url_launcher.dart';

class InstagramShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    final Uri _url = Uri.parse('instagram://sharesheet?text=$title\n$content');
    await launchUrl(_url);
    return;
  }
}
