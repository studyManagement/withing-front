import 'package:modi/common/sns_content_share/provider/clipboard_share.dart';
import 'package:modi/common/sns_content_share/provider/default_share.dart';
import 'package:modi/common/sns_content_share/provider/instagram_share.dart';
import 'package:modi/common/sns_content_share/provider/kakao_share.dart';
import 'package:modi/common/sns_content_share/provider/os_share.dart';
import 'package:modi/common/sns_content_share/provider/sms_share.dart';
import 'package:modi/common/sns_content_share/provider/twitter_share.dart';
import 'package:modi/common/sns_content_share/sns_content_share.dart';

enum SNSContentShareProviders {
  KAKAO,
  OS,
  INSTAGRAM,
  TWITTER,
  Clipboard,
  SMS,
}

class SNSContentShareFactory {
  static SNSContentShare getProvider(SNSContentShareProviders provider) {
    switch (provider) {
      case SNSContentShareProviders.KAKAO:
        return KakaoShare();
      case SNSContentShareProviders.OS:
        return OSShare();
      case SNSContentShareProviders.TWITTER:
        return TwitterShare();
      case SNSContentShareProviders.Clipboard:
        return ClipboardShare();
      case SNSContentShareProviders.SMS:
        return SmsShare();
      case SNSContentShareProviders.INSTAGRAM:
        return InstagramShare();
      default:
        return DefaultShare();
    }
  }
}
