import 'package:modi/common/logger/app_event.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/sns_content_share/provider/clipboard_share.dart';
import 'package:modi/common/sns_content_share/provider/default_share.dart';
import 'package:modi/common/sns_content_share/provider/instagram_share.dart';
import 'package:modi/common/sns_content_share/provider/kakao_share.dart';
import 'package:modi/common/sns_content_share/provider/os_share.dart';
import 'package:modi/common/sns_content_share/provider/sms_share.dart';
import 'package:modi/common/sns_content_share/provider/twitter_share.dart';
import 'package:modi/common/sns_content_share/sns_content_share.dart';
import 'package:modi/di/injection.dart';

enum SNSContentShareProviders {
  KAKAO,
  OS,
  INSTAGRAM,
  TWITTER,
  Clipboard,
  SMS,
}

class SNSContentShareFactory {
  static LoggingInterface _logger = getIt<LoggingInterface>();

  static SNSContentShare getProvider(
      SNSContentShareProviders provider, String contentType, String itemId) {
    _logger.appEvent(AppEvent.SHARE,
        method: provider.name, contentType: contentType, itemId: itemId);

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
