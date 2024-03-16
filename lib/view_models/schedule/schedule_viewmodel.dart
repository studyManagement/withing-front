import 'package:flutter/material.dart';
import 'package:modi/model/schedule/schedule_detail_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule.dart';
import 'package:modi/view_models/schedule/model/schedule_detail.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleService _service;
  List<Schedule> schedules = [];
  ScheduleDetail schedule =
      ScheduleDetail(-1, '', '', DateTime.now(), DateTime.now());

  ScheduleViewModel(this._service);

  Future<void> fetchSchedules(int studyId) async {
    List<ScheduleModel> scheduleModels = await _service.fetchSchedules(studyId);

    // inDays(yesterday=-1,today=0,tomorrow=1)
    scheduleModels.sort((a, b) => a.startAt.difference(b.startAt).inDays);
    schedules = scheduleModels.reversed.map((e) => Schedule.from(e)).toList();

    notifyListeners();
  }

  Future<void> fetchSchedule(int studyId, int studyScheduleId) async {
    ScheduleDetailModel scheduleModel =
        await _service.fetchSchedule(studyId, studyScheduleId);
    schedule = ScheduleDetail.from(scheduleModel);

    notifyListeners();
  }
}
