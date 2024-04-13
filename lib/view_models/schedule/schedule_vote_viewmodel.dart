import 'package:flutter/foundation.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/views/schedule/study/study_schedule_add_screen.dart';

class ScheduleVoteViewModel extends ChangeNotifier {
  final ScheduleService _service;

  List<ScheduleVote> votes = [];

  String title = '';
  String description = '';
  List<DateTime> selectedDates = [];
  DateTime startAt = DateTime.now();
  DateTime endAt = DateTime.now();

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

  Future<void> fetchScheduleVotes(int studyId) async {
    List<ScheduleVoteModel> scheduleVotes =
        await _service.fetchScheduleVotes(studyId);

    votes = scheduleVotes.map((e) => ScheduleVote.from(e)).toList();

    notifyListeners();
  }

  Future<void> postScheduleVote(int studyId) async {
    ScheduleVoteModel scheduleVote = await _service.postScheduleVote(
        studyId, title, description, selectedDates, startAt, endAt);

    logger.info('postScheduleVote: $scheduleVote');

    notifyListeners();
  }
}
