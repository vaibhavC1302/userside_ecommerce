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
    apiKey: 'AIzaSyDYkDmWyBQZx8NZCHEAPfXayMPIDNrPZOM',
    appId: '1:405290548092:web:35a4b1a5a97cc5bea1c2f9',
    messagingSenderId: '405290548092',
    projectId: 'emart-fire-flutt',
    authDomain: 'emart-fire-flutt.firebaseapp.com',
    storageBucket: 'emart-fire-flutt.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDjb8fzG8FVZczAeLaH1sQPTYLmb8YAyl4',
    appId: '1:405290548092:android:0a61defa7c5f50f9a1c2f9',
    messagingSenderId: '405290548092',
    projectId: 'emart-fire-flutt',
    storageBucket: 'emart-fire-flutt.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCdNIfoezU5652YLykRgcxhdVCn8ivXGi4',
    appId: '1:405290548092:ios:f68ef1135dd98e78a1c2f9',
    messagingSenderId: '405290548092',
    projectId: 'emart-fire-flutt',
    storageBucket: 'emart-fire-flutt.appspot.com',
    iosBundleId: 'com.example.usersideEcommerce',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCdNIfoezU5652YLykRgcxhdVCn8ivXGi4',
    appId: '1:405290548092:ios:41dbfd2d910caeb9a1c2f9',
    messagingSenderId: '405290548092',
    projectId: 'emart-fire-flutt',
    storageBucket: 'emart-fire-flutt.appspot.com',
    iosBundleId: 'com.example.usersideEcommerce.RunnerTests',
  );
}