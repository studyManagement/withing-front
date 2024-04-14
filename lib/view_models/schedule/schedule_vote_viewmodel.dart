import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';
import 'package:modi/view_models/schedule/model/schedule_vote.dart';
import 'package:modi/views/schedule/study/study_schedule_add_screen.dart';

class ScheduleVoteViewModel extends ChangeNotifier {
  final ScheduleService _service;

  List<ScheduleVote> votes = [];
  ScheduleVote? vote;

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

  Future<void> postScheduleVote(BuildContext context, int studyId) async {
    ScheduleVoteModel scheduleVote = await _service.postScheduleVote(
        studyId, title, description, selectedDates, startAt, endAt);

    logger.info('postScheduleVote: $scheduleVote');

    if (!context.mounted) {
      return;
    }

    context.go('/study/$studyId/schedule/${scheduleVote.id}');
  }
}
