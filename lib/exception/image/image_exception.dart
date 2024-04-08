class ImageException implements Exception {
  String cause;
  int code;
  ImageException(this.cause, this.code);
}
