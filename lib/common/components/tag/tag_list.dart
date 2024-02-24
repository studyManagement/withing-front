import 'package:flutter/cupertino.dart';
import 'package:modi/common/components/tag/tag.dart';

class TagList extends StatelessWidget {
  List<String> tags;

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var element in tags) {
      widgets.add(Tag(element, TagColorSet.BLUE));
      widgets.add(const SizedBox(width: 6));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: widgets,
    );
  }

  TagList(this.tags, {super.key});
}
