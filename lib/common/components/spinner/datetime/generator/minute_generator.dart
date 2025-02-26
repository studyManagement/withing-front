import 'package:modi/common/components/spinner/datetime/generator/date_time_generator.dart';

class MinuteGenerator implements DateTimeGenerator {
  @override
  List<String> makeElements(DateTime pickedDate) {
    List<String> elements = [];

    for (int i = 0; i < 60; i++) {
      int element = i;

      elements.add(element.toString().padLeft(2,'0'));
    }

    return elements;
  }
}
