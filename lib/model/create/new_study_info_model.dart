import 'dart:convert';

class NewStudyInfo {
  String studyName;
  int max;
  int isPrivate;
  String password;
  String explanation;
  List<int> categories;

  NewStudyInfo({
    required this.studyName,
    required this.max,
    required this.isPrivate,
    required this.password,
    required this.explanation,
    required this.categories,
  });

  Map<String, dynamic> toJson() {
    return {
      'studyName': studyName,
      'max': max,
      'isPrivate': isPrivate,
      'password': password,
      'explanation': explanation,
      'categories': categories,
    };
  }
}
