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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDpQ6gzAitmYYdLaVyNqZP8hLIWDTuw7bo',
    appId: '1:1047385066662:web:962c4e714e2e093b323867',
    messagingSenderId: '1047385066662',
    projectId: 'test-757e8',
    authDomain: 'test-757e8.firebaseapp.com',
    storageBucket: 'test-757e8.appspot.com',
    measurementId: 'G-2G8X44H6Z0',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCehaFF1uNBhWBbjBaYzjIk0-UkoZLFDtk',
    appId: '1:1047385066662:android:ae73f9c5a0221363323867',
    messagingSenderId: '1047385066662',
    projectId: 'test-757e8',
    storageBucket: 'test-757e8.appspot.com',
  );
}