import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:modi/common/sns_content_share/sns_content_share.dart';

class KakaoShare implements SNSContentShare {
  Future<bool> isAvailable() async {
    return ShareClient.instance.isKakaoTalkSharingAvailable();
  }

  Future<void> send(String title, String content) async {
    bool isAvailable = await this.isAvailable();

    TextTemplate template = makeTextTemplate('${title}\n${content}');
    Uri uri = await ShareClient.instance.shareDefault(template: template);

    if (!isAvailable) {
      await launchBrowserTab(uri, popupOpen: true);
      return;
    }

    await ShareClient.instance.launchKakaoTalk(uri);
    return;
  }

  TextTemplate makeTextTemplate(String content) {
    return TextTemplate(
      text: content,
      link: Link(
          webUrl: Uri.parse('https://developer.kakao.com'),
          mobileWebUrl: Uri.parse('https://developer.kakao.com')),
    );
  }
}
