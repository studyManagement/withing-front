enum StudyType {
  LIKE(key: 'like'),
  MY(key: 'mystudy'),
  FINISHED(key: 'finished');

  const StudyType({required this.key});

  final String key;

  static StudyType from(String studyType) {
    return StudyType.values.byName(studyType.toUpperCase());
  }
}
