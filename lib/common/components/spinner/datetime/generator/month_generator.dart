import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';

class MonthGenerator implements DateTimeGenerator {
  @override
  List<String> makeElements(DateTime pickedDate) {
    List<String> elements = [];

    for (int i = 1; i < 13; i++) {
      int element = i;
      elements.add(element.toString());
    }

    return elements;
  }
}
