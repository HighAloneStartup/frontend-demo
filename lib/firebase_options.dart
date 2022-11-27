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
    apiKey: 'AIzaSyBLaEeziPUpiIx3P64PAIOZS5sCDgSPRTk',
    appId: '1:101473906450:web:94d517345ae081a7994dcb',
    messagingSenderId: '101473906450',
    projectId: 'cau-capston-dm',
    authDomain: 'cau-capston-dm.firebaseapp.com',
    storageBucket: 'cau-capston-dm.appspot.com',
    measurementId: 'G-TDKBS6T202',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCSGkiX7Sh9rPNLUWYKd_l1avxjZLJ2dv0',
    appId: '1:101473906450:android:18da5d08c3145c12994dcb',
    messagingSenderId: '101473906450',
    projectId: 'cau-capston-dm',
    storageBucket: 'cau-capston-dm.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCWiGGj3m8Sg-wgZpqC1H_qu6Yh_evSQVE',
    appId: '1:101473906450:ios:3f59a4b6c227dda7994dcb',
    messagingSenderId: '101473906450',
    projectId: 'cau-capston-dm',
    storageBucket: 'cau-capston-dm.appspot.com',
    iosClientId: '101473906450-1u89s454htg0fug3sig41ai251ic2i75.apps.googleusercontent.com',
    iosBundleId: 'com.example.highAloneStartup',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCWiGGj3m8Sg-wgZpqC1H_qu6Yh_evSQVE',
    appId: '1:101473906450:ios:3f59a4b6c227dda7994dcb',
    messagingSenderId: '101473906450',
    projectId: 'cau-capston-dm',
    storageBucket: 'cau-capston-dm.appspot.com',
    iosClientId: '101473906450-1u89s454htg0fug3sig41ai251ic2i75.apps.googleusercontent.com',
    iosBundleId: 'com.example.highAloneStartup',
  );
}
