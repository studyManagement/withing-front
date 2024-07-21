import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/common/requester/api_exception.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/model/schedule/vote_date_time_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/views/schedule/study/study_schedule_add_screen.dart';

import '../../common/modal/modi_modal.dart';

class ScheduleVoteViewModel extends ChangeNotifier {
  final ScheduleService _service;

  List<ScheduleVote> votes = [];
  List<VoteDateTimeModel> votedDateTimeList = [];
  List<DateTime> selectedDatetimeList = [];
  ScheduleVote? vote;

  String title = '';
  String description = '';
  List<DateTime> selectedDates = [DateTime.now()];
  DateTime startAt = DateTime.now();
  DateTime endAt = DateTime.now();
  bool isClosed = false;

  ScheduleVoteViewModel(this._service);

  void setTitle(String title) {
    this.title = title;
  }

  void setDescription(String description) {
    this.description = description;
  }

  void setSelectedDates(List<DateTime> selectedDates) {
    this.selectedDates = selectedDates;
  }

  void setStartAt(DateTime startAt) {
    this.startAt = startAt;
  }

  void setEndAt(DateTime endAt) {
    this.endAt = endAt;
  }

  void selectVoteDateAndTimes(DateTime dateTime) {
    if (selectedDatetimeList.contains(dateTime)) {
      selectedDatetimeList.remove(dateTime);
    } else {
      selectedDatetimeList.add(dateTime);
    }
  }

  _convertDateTimesToVoteDateTimeModels() {
    // 날짜별로 그룹화된 Map 생성
    final Map<String, List<String>> groupedByDate = {};

    for (final dateTime in selectedDatetimeList) {
      final dateKey =
          "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
      final timeValue =
          "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";

      groupedByDate.putIfAbsent(dateKey, () => []).add(timeValue);
    }
    // 그룹화된 Map을 List<VoteDateTimeModel>로 변환
    votedDateTimeList = groupedByDate.entries.map((entry) {
      // 시간을 정렬
      entry.value.sort();
      return VoteDateTimeModel(entry.key, entry.value);
    }).toList();
    // 날짜별로 정렬
    votedDateTimeList.sort((a, b) => a.voteDay.compareTo(b.voteDay));
    // for(var i in votedDateTimeList){
    //   print(i.voteDay);
    //   print(i.selectedTimes);
    // }
  }

  Future<void> fetchScheduleVote(int studyId, int voteId) async {
    ScheduleVoteModel scheduleVote =
        await _service.fetchScheduleVote(studyId, voteId);
    vote = ScheduleVote.from(scheduleVote);
    vote!.votes.sort((a, b) => a.voteDay.compareTo(b.voteDay));
    notifyListeners();
  }

  Future<void> fetchScheduleVotes(int studyId) async {
    List<ScheduleVoteModel> scheduleVotes =
        await _service.fetchScheduleVotes(studyId);

    votes = scheduleVotes.map((e) => ScheduleVote.from(e)).toList();
    votes.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    notifyListeners();
  }

  Future<void> postScheduleVote(BuildContext context, int studyId) async {// 투표 생성
    try {
      if (startAt.isAfter(endAt)) {
        if (!context.mounted) return;
        ModiModal.openDialog(context, '오류가 발생했어요', '시작 시간이 종료 시간보다 늦을 수 없어요.',
            false, () => context.pop(), () => null);
        return;
      }
      ScheduleVoteModel scheduleVote = await _service.postScheduleVote(
          studyId, title, description, selectedDates, startAt, endAt);

      logger.info('postScheduleVote: $scheduleVote');

      if (!context.mounted) {
        return;
      }
      context.go('/studies/$studyId/schedules/vote/${scheduleVote.id}');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }

  Future<void> castVote(BuildContext context, int studyId, int scheduleId) async { // 투표 하기
    try {
      vote = null;
      _convertDateTimesToVoteDateTimeModels();
      ScheduleVoteModel scheduleVote =
          await _service.vote(studyId, scheduleId, votedDateTimeList);
      if (!context.mounted) {
        return;
      }
      context.pop();
      context.pop();
      context.push('/studies/$studyId/schedules/vote/${scheduleVote.id}');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }

  Future<void> closeVote(BuildContext context, int studyId, int voteId) async {
    try {
      ScheduleVoteModel scheduleVote =
          await _service.closeVote(studyId, voteId);
      isClosed = true;
      logger.info('putScheduleVote: $scheduleVote');

      if (!context.mounted) return;
      context.go('/studies/$studyId/schedules/vote/${scheduleVote.id}');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }

  Future<void> deleteVote(BuildContext context, int studyId, int voteId) async {
    try {
      ScheduleVoteModel scheduleVote =
          await _service.deleteVote(studyId, voteId);

      logger.info('deleteScheduleVote: $scheduleVote');

      if (!context.mounted) return;
      context.go('/studies/$studyId/schedules');
    } on ApiException catch (e) {
      ModiModal.openDialog(context, '문제가 발생했어요', e.cause, false, null, null);
    }
  }
}
