import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';

class DayGenerator implements DateTimeGenerator {
  @override
  List<String> makeElements(DateTime pickedDate) {
    List<String> elements = [];

    int maxDayOfMonth = _getLastDayOfMonth(pickedDate.year, pickedDate.month);

    for (int i = 1; i < maxDayOfMonth + 1; i++) {
      int element = i;
      elements.add(element.toString());
    }

    return elements;
  }

  int _getLastDayOfMonth(int year, int month) {
    if (month == 2) {
      if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
        return 29; // 윤년
      } else {
        return 28;
      }
    } else if ([4, 6, 9, 11].contains(month)) {
      return 30;
    } else {
      return 31;
    }
  }
}
