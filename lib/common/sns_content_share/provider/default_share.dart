import 'package:modi/common/sns_content_share/sns_content_share.dart';

class DefaultShare implements SNSContentShare {
  Future<void> send(String title, String content) async {
    return Future(() => null);
  }
}
