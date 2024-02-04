import 'package:modi/common/authenticator/authenticator.dart';

class EmptyAuthentication implements Authenticator {
  @override
  Future<int> fetchUUID() {
    // TODO: implement fetchUUID
    throw UnimplementedError();
  }

  @override
  String getProvider() {
    // TODO: implement getProvider
    throw UnimplementedError();
  }

  @override
  Future<String> login() {
    // TODO: implement login
    throw UnimplementedError();
  }
}
