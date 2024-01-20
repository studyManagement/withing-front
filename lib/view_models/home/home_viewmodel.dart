import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  late DateTime _selectedDate;

  setSelectDate(DateTime date) {
    _selectedDate = date;
  }

  get selectedDate => _selectedDate;
}
