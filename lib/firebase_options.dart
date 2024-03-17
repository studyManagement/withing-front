// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC8MaNy_ShEAK-6q4Rs6tr5G5v-uHPyWpQ',
    appId: '1:941895894851:web:dfca59ffee6a06ddb311f6',
    messagingSenderId: '941895894851',
    projectId: 'modi-31349',
    authDomain: 'modi-31349.firebaseapp.com',
    storageBucket: 'modi-31349.appspot.com',
    measurementId: 'G-D9FEK0Q63Z',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCrqbKr2dXJp75buRZdVLR6cJTNIiB3AKY',
    appId: '1:941895894851:android:99d994da51ccffd4b311f6',
    messagingSenderId: '941895894851',
    projectId: 'modi-31349',
    storageBucket: 'modi-31349.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDQ2t2u1bNVqhgtg_x4Pj-WEyn-XRKSBFc',
    appId: '1:941895894851:ios:0fa5719b16007a45b311f6',
    messagingSenderId: '941895894851',
    projectId: 'modi-31349',
    storageBucket: 'modi-31349.appspot.com',
    iosBundleId: 'io.moditeam.modi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDQ2t2u1bNVqhgtg_x4Pj-WEyn-XRKSBFc',
    appId: '1:941895894851:ios:90f76fa945a23185b311f6',
    messagingSenderId: '941895894851',
    projectId: 'modi-31349',
    storageBucket: 'modi-31349.appspot.com',
    iosBundleId: 'com.example.withing.RunnerTests',
  );
}
