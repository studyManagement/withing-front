class ApiException implements Exception {
  String cause;
  int code;
  ApiException(this.cause, this.code);
}
