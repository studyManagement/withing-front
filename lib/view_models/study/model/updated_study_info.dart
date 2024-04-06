class UpdatedStudyInfo {
  final String? studyName;
  final String? explanation;
  final List<int>? categories;
  final int? max;
  final String? uuid;

  UpdatedStudyInfo(
      this.studyName, this.explanation, this.categories, this.max, this.uuid);

  Map<String, dynamic> toJson() {
    return {
      'studyName': studyName,
      'max': max,
      'explanation': explanation,
      'categories': categories,
      'uuid': uuid
    };
  }
}
