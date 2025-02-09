import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class CustomTagController extends TextEditingController {
  CustomTagController({String? text}) : super(text: text);

  List<String> getTextToWordArr() {
    return text.split(' ');
  }

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    if (text.isEmpty) {
      return TextSpan(text: '', style: style);
    }

    List<String> words = text.split(' ');
    List<TextSpan> children = [];

    for (int i = 0; i < words.length; i++) {
      String word = words[i];

      // @로 시작하는 단어인지 확인
      if (word.startsWith('@') && word.length > 1 && !word.contains('@', 1)) {
        // @이름에 스타일 적용
        children.add(
          TextSpan(
            text: word, // @이름
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: AppColors.blue500,
              backgroundColor: AppColors.blue100,
            ),
          ),
        );

        // @이름 뒤에 공백 추가
        if (i < words.length - 1) {
          children.add(
            TextSpan(
              text: ' ', // 공백
              style: style,
            ),
          );
        }
      } else {
        // 일반 텍스트, 공백 처리
        children.add(
          TextSpan(
            text: '$word${i < words.length - 1 ? ' ' : ''}',
            style: style,
          ),
        );
      }
    }

    return TextSpan(children: children);
  }
}