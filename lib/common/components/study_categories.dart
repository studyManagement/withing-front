import 'package:flutter/cupertino.dart';

class StudyCategories extends StatelessWidget {
  final List<String> categories;

  const StudyCategories({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [];

    for (var category in categories) {
      widgets.add(
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: ShapeDecoration(
            color: const Color(0xFFE3F1FF),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Text(
            category,
            style: const TextStyle(
              color: Color(0xFF3771E0),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );

      if (category != categories.last) {
        widgets.add(const SizedBox(width: 6));
      }
    }

    return Row(children: widgets);
  }
}
