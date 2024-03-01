class UpdatedStudyInfo {
  final String? studyName;
  final String? explanation;
  final List<int>? categories;
  final int? max;

  UpdatedStudyInfo( this.studyName, this.explanation,
      this.categories, this.max);

  Map<String, dynamic> toJson() {
    return {
      'studyName': studyName,
      'max': max,
      'explanation': explanation,
      'categories': categories,
    };
  }
}
