import 'package:flutter/foundation.dart';
import 'package:modi/model/schedule/schedule_vote_model.dart';
import 'package:modi/service/schedule/schedule_service.dart';

class ScheduleVoteViewModel extends ChangeNotifier {
  final ScheduleService _service;

  ScheduleVoteViewModel(this._service);

  Future<void> fetchScheduleVotes(int studyId) async {
    List<ScheduleVoteModel> scheduleVotes =
        await _service.fetchScheduleVotes(studyId);

    notifyListeners();
  }
}
