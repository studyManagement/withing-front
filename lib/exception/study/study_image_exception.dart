class StudyImageException implements Exception {
  String cause;
  int code;
  StudyImageException(this.cause, this.code);
}
