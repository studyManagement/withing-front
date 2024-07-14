class VoteDateTimeModel {
  final String voteDay;
  final List<String> selectedTimes;

  VoteDateTimeModel(this.voteDay, this.selectedTimes);

  Map<String, dynamic> toJson() {
    return {
      'voteDay': voteDay,
      'selectedTime': selectedTimes,
    };
  }
}
