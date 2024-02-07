class StudyException implements Exception {
  String cause;
  int code;
  StudyException(this.cause, this.code);
}
