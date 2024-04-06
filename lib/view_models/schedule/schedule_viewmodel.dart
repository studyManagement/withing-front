import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/common/modal/modi_modal.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/di/injection.dart';
import 'package:modi/model/schedule/schedule_detail_model.dart';
import 'package:modi/model/schedule/schedule_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule.dart';
import 'package:modi/view_models/schedule/model/schedule_detail.dart';

class ScheduleViewModel extends ChangeNotifier {
  final ScheduleService _service;
  final LoggingInterface _logger = getIt<LoggingInterface>();
  List<Schedule> schedules = [];
  ScheduleDetail schedule =
      ScheduleDetail(-1, '', '', DateTime.now(), DateTime.now());
  String title = '';
  String description = '';
  late DateTime startAt = DateTime.now();
  late DateTime endAt = DateTime.now();
  int selectItem = 1;

  ScheduleViewModel(this._service);

  void setSelectItem(int index) {
    selectItem = index;
    notifyListeners();
  }

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setStartAt(DateTime startAt) {
    this.startAt = startAt;
    notifyListeners();
  }

  void setEndAt(DateTime endAt) {
    this.endAt = endAt;
    notifyListeners();
  }

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

  Future<void> postSchedule(BuildContext context, int studyId, String title,
      String description, DateTime startAt, DateTime endAt) async {
    try {
      ScheduleModel schedule = await _service.postStudySchedule(
          studyId, title, description, startAt, endAt);

      if (!context.mounted) {
        return;
      }

      context.go('/studies/$studyId/schedules/${schedule.id}');
    } on ApiException catch (e) {
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        e.cause,
        false,
        () => context.pop(),
        () => null,
      );
    }
  }
}
