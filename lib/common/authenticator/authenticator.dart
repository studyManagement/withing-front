class Authenticator {
  Future<String> login() async {
    // inherit subclass
    return '';
  }

  String getProvider() {
    return '';
  }

  Future<String> fetchUUID() async {
    return '';
  }
}
