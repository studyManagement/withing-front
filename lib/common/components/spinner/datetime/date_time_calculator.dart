class DateTimeCalculator {
  late int _year;
  late int _month;
  late int _day;
  late bool _isAM;
  late int _hour;
  late int _minute;
  late Function(DateTime) _onChanged;

  DateTimeCalculator(Function(DateTime) onChanged, DateTime standard) {
    _onChanged = onChanged;
    _year = standard.year;
    _month = standard.month;
    _day = standard.day;
    _isAM = (standard.hour > 11);
    _hour = standard.hour;
    _minute = standard.minute;
  }

  setYear(String year) {
    _year = int.parse(year);
    _onChanged(_makeDateTime());
  }

  setMonth(String month) {
    _month = int.parse(month);
    _onChanged(_makeDateTime());
  }

  setDay(String day) {
    _day = int.parse(day);
    _onChanged(_makeDateTime());
  }

  setPart(String part) {
    if (part == '오전') {
      _isAM = true;
      _onChanged(_makeDateTime());
      return;
    }

    _isAM = false;
    _onChanged(_makeDateTime());
  }

  setHour(String hour) {
    _hour = int.parse(hour);
    _onChanged(_makeDateTime());
  }

  setMinute(String minute) {
    _minute = int.parse(minute);
    _onChanged(_makeDateTime());
  }

  DateTime _makeDateTime() {
    return DateTime(
      _year,
      _month,
      _day,
      (!_isAM) ? _hour + 12 : _hour,
      _minute,
    );
  }
}
