import 'package:flutter/cupertino.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/model/user/user_model.dart';

class LoggingInterface {
  void info(dynamic message) {}
  void warn(dynamic message) {}
  void debug(dynamic message) {}
  void error(dynamic message) {}
  void setUser(int id, {UserModel? user}) {}
  void appEvent(AppEvent event,
      {required String method,
      String? contentType,
      String? itemId,
      Map<String, Object>? parameters}) {}
  NavigatorObserver getObserver() {
    throw Exception("interface is not implemented");
  }
}
