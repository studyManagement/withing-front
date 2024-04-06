class NewStudyInfo {
  String studyName;
  int max;
  int isPrivate;
  String password;
  String explanation;
  List<int> categories;
  String? uuid;

  NewStudyInfo({
    required this.studyName,
    required this.max,
    required this.isPrivate,
    required this.password,
    required this.explanation,
    required this.categories,
    required this.uuid,
  });

  Map<String, dynamic> toJson() {
    return {
      'studyName': studyName,
      'max': max,
      'isPrivate': isPrivate,
      'password': password,
      'explanation': explanation,
      'categories': categories,
      'uuid': uuid,
    };
  }
}
