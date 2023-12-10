import 'package:flutter_dotenv/flutter_dotenv.dart';

enum BuildType { LOCAL, DEV, PROD }

class Environment {
  static String getEnv(String key) {
    return dotenv.get(key);
  }

  static initialize(BuildType type) async {
    switch (type) {
      case BuildType.LOCAL:
        await dotenv.load(fileName: ".local.env");
        break;

      default:
        break;
    }
  }
}
