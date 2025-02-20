import 'package:flutter/cupertino.dart';
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
  List<Schedule>? schedules;
  ScheduleDetail schedule =
      ScheduleDetail(-1, '', '', DateTime.now(), DateTime.now());

  FixedExtentScrollController controller = FixedExtentScrollController();
  bool _isInitialized = false;


  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool isChanged = false;

  ScheduleViewModel(this._service);

  void setTitle(String title) {
    schedule.title = title;
  }

  void setDescription(String description) {
    schedule.description = description;
  }

  void setStartAt(DateTime startAt) {
    schedule.startAt = startAt;
  }

  void setEndAt(DateTime endAt) {
    schedule.endAt = endAt;
  }
  


  Future<void> fetchSchedules(int studyId) async {
    List<ScheduleModel> scheduleModels = await _service.fetchSchedules(studyId);

    scheduleModels.sort((a, b) => a.startAt.compareTo(b.startAt));
    schedules = scheduleModels.reversed.map((e) => Schedule.from(e)).toList();

    notifyListeners();
  }

  Future<void> fetchSchedule(int studyId, int studyScheduleId) async {
    ScheduleDetailModel scheduleModel =
        await _service.fetchSchedule(studyId, studyScheduleId);
    schedule = ScheduleDetail.from(scheduleModel);
    _isLoading = false;

    notifyListeners();
  }

  void initialize() { // 생성 시
    if (!_isInitialized) {
      DateTime now = DateTime.now();
      setStartAt(now);
      setEndAt(now);
      _isLoading = false;
      _isInitialized = true;
    }
  }


  void setIsLoading(bool isLoading) {
    _isLoading = isLoading;
   // notifyListeners();
  }

  Future<void> deleteSchedule(BuildContext context, int studyId) async {
    try {
      await _service.deleteStudySchedule(studyId, schedule.id);

      if (!context.mounted) {
        return;
      }

      context.go('/studies/$studyId/schedules');
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

  bool checkEverythingFilled(BuildContext context) {
    if (schedule.title.replaceAll(' ', '').isEmpty) {
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        '일정 제목을 입력해주세요.',
        false,
        () => context.pop(),
        () => null,
      );
      return false;
    }

    if (schedule.description.replaceAll(' ', '').isEmpty) {
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        '일정 내용을 입력해주세요.',
        false,
        () => context.pop(),
        () => null,
      );
      return false;
    }

    if (schedule.startAt.isAfter(schedule.endAt)) {
      ModiModal.openDialog(
        context,
        '오류가 발생했어요',
        '시작일이 종료일보다 늦을 수 없어요',
        false,
        () => context.pop(),
        () => null,
      );
      return false;
    }

    return true;
  }

  Future<void> putSchedule(
      BuildContext context, int studyId, int studyScheduleId) async {
    try {
      if (!checkEverythingFilled(context)) {
        return;
      }

      ScheduleModel schedule = await _service.putStudySchedule(
          studyId,
          studyScheduleId,
          this.schedule.title,
          this.schedule.description,
          this.schedule.startAt,
          this.schedule.endAt);

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

  Future<void> postSchedule(BuildContext context, int studyId) async {
    try {
      if (!checkEverythingFilled(context)) {
        return;
      }

      ScheduleModel schedule = await _service.postStudySchedule(
          studyId,
          this.schedule.title,
          this.schedule.description,
          this.schedule.startAt,
          this.schedule.endAt);

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
