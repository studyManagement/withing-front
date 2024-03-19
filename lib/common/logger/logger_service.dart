import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:logger/logger.dart';
import 'package:modi/common/logger/app_event.dart';
import 'package:modi/common/logger/logging_interface.dart';
import 'package:modi/model/user/user_model.dart';

class LoggerService implements LoggingInterface {
  static final LoggingInterface _instance = LoggerService._privateConstructor();
  static final FirebaseAnalytics _firebaseAnalytics =
      FirebaseAnalytics.instance;
  static final FirebaseAnalyticsObserver _observer =
      FirebaseAnalyticsObserver(analytics: _firebaseAnalytics);
  static final Logger _logger = Logger();
  static LoggingInterface get instance => _instance;

  @override
  void appEvent(AppEvent event,
      {
        required String method,
        String? groupId,
        String? contentType,
        String? itemId,
        Map<String, Object>? parameters},) {
    // @Example https://github.com/firebase/flutterfire/blob/master/packages/firebase_analytics/firebase_analytics/example/lib/main.dart

    _logger.i(
        'AppEvent(appEvent=${event.name},method=$method,contentType=$contentType,itemId=$itemId,parameters=$parameters)');

    switch (event) {
      case AppEvent.APP_OPEN:
        _firebaseAnalytics.logAppOpen();
        break;
      case AppEvent.LOGIN:
        _firebaseAnalytics.logLogin(
            loginMethod: method, parameters: parameters);
        break;
      case AppEvent.SIGNUP:
        _firebaseAnalytics.logSignUp(
            signUpMethod: method, parameters: parameters);
        break;
      case AppEvent.SHARE:
        assert(contentType != null && itemId != null,
            "SHARE 이벤트는 ContentType하고 ItemId 인자가 null이 아니여야 합니다.");

        _firebaseAnalytics.logShare(
          contentType: contentType!,
          itemId: itemId!,
          method: method,
          parameters: parameters,
        );
        break;

      case AppEvent.JOIN_GROUP:
        assert(groupId != null, 'JOIN_GROUP 이벤트는 groupId 인자가 null이 아니여야 합니다.');
        _firebaseAnalytics.logJoinGroup(groupId: groupId!, parameters: parameters);
        break;
    }
  }

  @override
  void debug(dynamic message) {
    _logger.d(message);
  }

  @override
  void info(dynamic message) {
    _logger.i(message);
  }

  @override
  void warn(dynamic message) {
    _logger.w(message);
  }

  @override
  void error(dynamic message) {
    _logger.e(message);
  }

  @override
  NavigatorObserver getObserver() {
    return LoggerService._observer;
  }

  LoggerService._privateConstructor();

  @override
  void setUser(int id, {UserModel? user}) {
    _firebaseAnalytics.setUserId(id: id.toString());
    _firebaseAnalytics.setUserProperty(
        name: 'os', value: Platform.operatingSystem);
    _firebaseAnalytics.setUserProperty(
        name: 'os_version', value: Platform.operatingSystemVersion);

    if (user != null) {
      _firebaseAnalytics.setUserProperty(
          name: 'nickname', value: user.nickname);
    }
  }
}
