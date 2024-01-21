import 'dart:convert';

class NewStudyInfo {
  String studyName;
  int max;
  int isPrivate;
  String password;
  String explanation;
  int leaderId;
  List<int> categories;
  int? studyId;

  NewStudyInfo({
    required this.studyName,
    required this.max,
    required this.isPrivate,
    required this.password,
    required this.explanation,
    required this.leaderId,
    required this.categories,
    required this.studyId,
  });

  String toJsonString() {
    return jsonEncode({
      'studyName': studyName,
      'max': max,
      'isPrivate': isPrivate,
      'password': password,
      'explanation': explanation,
      'leaderId': leaderId,
      'categories': categories,
      'studyId': studyId,
    });
  }
}
