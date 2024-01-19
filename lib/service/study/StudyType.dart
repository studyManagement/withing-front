enum StudyType {
  LIKE(key: 'like'),
  MY(key: 'mystudy'),
  FINISHED(key: 'finished');

  const StudyType({required this.key});

  final String key;
}
