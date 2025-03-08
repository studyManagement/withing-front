class UpdatedStudyInfo {
  final String? studyName;
  final String? explanation;
  final List<int>? categories;
  final int? max;
  final bool? isPrivate;
  final String password;
  final String? uuid;

  UpdatedStudyInfo(
      this.studyName, this.explanation, this.categories, this.max,  this.isPrivate, this.password, this.uuid);

  Map<String, dynamic> toJson() {
    return {
      'studyName': studyName,
      'max': max,
      'explanation': explanation,
      'categories': categories,
      'isPrivate': isPrivate,
      'password': password,
      'uuid': uuid
    };
  }
}
