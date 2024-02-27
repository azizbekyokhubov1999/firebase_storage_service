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
    apiKey: 'AIzaSyBVaskz6VXJZ8aHSRNxHSmk5wNjpMWYs_A',
    appId: '1:322332202116:web:e109872117ce423edc9ed1',
    messagingSenderId: '322332202116',
    projectId: 'storageservice-e8d32',
    authDomain: 'storageservice-e8d32.firebaseapp.com',
    storageBucket: 'storageservice-e8d32.appspot.com',
    measurementId: 'G-2F791J0LKB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDMaqq6Sn6oVtr7yW_CxqiD4CriUyuFZR8',
    appId: '1:322332202116:android:69cebd5a568a347bdc9ed1',
    messagingSenderId: '322332202116',
    projectId: 'storageservice-e8d32',
    storageBucket: 'storageservice-e8d32.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_9T44ZrqvF_fWY18_pzr5mRHRo1aY_bI',
    appId: '1:322332202116:ios:0821a7693dc7a28ddc9ed1',
    messagingSenderId: '322332202116',
    projectId: 'storageservice-e8d32',
    storageBucket: 'storageservice-e8d32.appspot.com',
    iosBundleId: 'com.example.firebaseStorageService',
  );
}
