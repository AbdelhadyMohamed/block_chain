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
    apiKey: 'AIzaSyBPzKvGnAITHPpeRuClNZI7LztjdbU5ucY',
    appId: '1:166747091532:web:3f0b9950f4197ad117bae9',
    messagingSenderId: '166747091532',
    projectId: 'block-chain-13f86',
    authDomain: 'block-chain-13f86.firebaseapp.com',
    storageBucket: 'block-chain-13f86.appspot.com',
    measurementId: 'G-Q063ZF0F59',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAHyoaxeaBvOs4M2bTXK6lcoZvVms8qjKU',
    appId: '1:166747091532:android:f5fe32d0a32e786d17bae9',
    messagingSenderId: '166747091532',
    projectId: 'block-chain-13f86',
    storageBucket: 'block-chain-13f86.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAc_GFotppGWANIUu6NYNzduAsotnSCs-c',
    appId: '1:166747091532:ios:a89f232e453a91b517bae9',
    messagingSenderId: '166747091532',
    projectId: 'block-chain-13f86',
    storageBucket: 'block-chain-13f86.appspot.com',
    iosBundleId: 'com.example.blockChain',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAc_GFotppGWANIUu6NYNzduAsotnSCs-c',
    appId: '1:166747091532:ios:a3860f5deea0895717bae9',
    messagingSenderId: '166747091532',
    projectId: 'block-chain-13f86',
    storageBucket: 'block-chain-13f86.appspot.com',
    iosBundleId: 'com.example.blockChain.RunnerTests',
  );
}
