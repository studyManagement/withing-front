class Authenticator {
  Future<String> login() async {
    // inherit subclass
    return '';
  }

  String getProvider() {
    return '';
  }

  Future<int> fetchUUID() async {
    return -1;
  }
}
