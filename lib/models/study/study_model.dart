class StudyModel {
  late num _id;
  late num _leaderUID;
  late String _name;
  late String _explanation;
  late num _maximumPeople;
  late num _currentPeople;
  late bool _isPrivate;
  late bool _isFinished;
  late DateTime _createdDate;
  late DateTime _deadline;

  StudyModel(
      this._id,
      this._leaderUID,
      this._name,
      this._explanation,
      this._maximumPeople,
      this._currentPeople,
      this._isPrivate,
      this._isFinished,
      this._createdDate,
      this._deadline);

  factory StudyModel.fromJson(Map<String, dynamic> data) {
    return StudyModel(
        data['studyId'],
        data["leaderId"],
        data['studyName'],
        data['explanation'],
        data['max'],
        data['headcount'],
        data['isPrivate'],
        data['isFinished'],
        data['createdDate'],
        data['deadline']);
  }

  String toJson() {
    return '';
  }

  num get id => _id;
  num get leaderUID => _leaderUID;
  String get name => _name;
  String get explanation => _explanation;
  num get maximumPeople => _maximumPeople;
  num get currentPeople => _currentPeople;
  bool get isPrivate => _isPrivate;
  bool get isFinished => _isFinished;
  DateTime get createdDate => _createdDate;
  DateTime get deadline => _deadline;
}
