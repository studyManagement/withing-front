import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';

class YearGenerator implements DateTimeGenerator {
  @override
  List<String> makeElements(DateTime pickedDate) {
    List<String> elements = [];

    for (int i = -1; i < 2; i++) {
      int element = pickedDate.year + i;
      elements.add(element.toString());
    }

    return elements;
  }
}
