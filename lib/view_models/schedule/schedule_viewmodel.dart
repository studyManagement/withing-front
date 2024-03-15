import 'package:flutter/material.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleService _service;
  List<Schedule> schedules = [];

  ScheduleViewModel(this._service);

  Future<void> fetchSchedules(int studyId) async {
    List<ScheduleModel> scheduleModels = await _service.fetchMyStudies(studyId);
    schedules = scheduleModels.map((e) => Schedule.from(e)).toList();

    notifyListeners();
  }
}
