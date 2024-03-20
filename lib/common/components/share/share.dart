import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/button/label_circle_button.dart';
import 'package:modi/common/sns_content_share/sns_content_share_factory.dart';
import 'package:modi/common/theme/app/app_colors.dart';
import 'package:modi/common/theme/app/app_fonts.dart';

class Share extends StatelessWidget {
  const Share({
    required this.title,
    required this.message,
    required this.path,
    required this.contentType,
    required this.itemId,
    required this.onTap,
    super.key,
  });

  final String title;
  final String message;
  final String path;
  final String contentType;
  final String itemId;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          '공유하기',
          style: TextStyle(
            color: AppColors.gray800,
            fontSize: 16,
            fontWeight: AppFonts.fontWeight600,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: GridView(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            children: [
              _makeButton(
                '복사',
                'asset/share/clipboard.png',
                SNSContentShareProviders.Clipboard,
              ),
              _makeButton(
                '카카오톡',
                'asset/share/kakao.png',
                SNSContentShareProviders.KAKAO,
              ),
              _makeButton(
                '인스타그램',
                'asset/share/instagram.png',
                SNSContentShareProviders.INSTAGRAM,
              ),
              _makeButton(
                '더보기',
                'asset/share/more.png',
                SNSContentShareProviders.OS,
              ),
            ],
          ),
        ),
      ],
    );
  }

  LabelCircleButton _makeButton(
      String name, String asset, SNSContentShareProviders provider) {
    return LabelCircleButton(
      name,
      Image.asset(
        asset,
        width: 50,
        height: 50,
      ),
      () {
        onTap();
        SNSContentShareFactory.getProvider(provider, contentType, itemId).send(
          title,
          '$message\n\nhttps://modi.tips/_s/${base64.encode(utf8.encode(path))}',
        );
      },
    );
  }
}
