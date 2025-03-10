import 'package:flutter/material.dart';
import '../../../common/theme/app/app_colors.dart';

class CustomTagController extends TextEditingController {
  String? lastAddedTag;

  CustomTagController({String? text}) : super(text: text);

  void updateInnerText(String name) {
    List<String> words = getTextToWordArr();
    String lastWord = words.last;

    if (lastWord.startsWith('@')) {
      words.removeLast();
    }
    lastAddedTag = '@$name';
    String newText = words.isEmpty ? '@$name ' : '${words.join(' ')} @$name ';

    value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

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

      if (word == lastAddedTag) {
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
        children.add(
          TextSpan(
            text: ' ',
            style: style
          )
        );
      } else {
        // 일반 텍스트, 공백 처리
        children.add(
          TextSpan(
            text: '$word ',
            style: style,
          ),
        );
      }
    }
    return TextSpan(children: children);
  }
}