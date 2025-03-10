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
    List<InlineSpan> children = [];

    for (String word in words) {
      if (word == lastAddedTag) {
        children.add(
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.blue100,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                word,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blue500,
                  fontSize: 13.0,
                ),
              ),
            ),
          ),
        );
        children.add(
          WidgetSpan(
            child: Text(' ', style: style),
          ),
        );
      } else {
        children.add(
          TextSpan(
            text: '$word',
            style: style,
          ),
        );
      }
    }
    return TextSpan(children: children);
  }

}