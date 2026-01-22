import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
        return windows;
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
    apiKey: 'AIzaSyBR1RRYXFJ8puOQCW2yMZ4o-qv0dHno21s',
    appId: '1:927847752780:web:27470916b99bbf8197c0e9',
    messagingSenderId: '927847752780',
    projectId: 'uas-catfish-project',
    authDomain: 'uas-catfish-project.firebaseapp.com',
    storageBucket: 'uas-catfish-project.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBR1RRYXFJ8puOQCW2yMZ4o-qv0dHno21s',
    appId: '1:927847752780:android:27470916b99bbf8197c0e9',
    messagingSenderId: '927847752780',
    projectId: 'uas-catfish-project',
    storageBucket: 'uas-catfish-project.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBR1RRYXFJ8puOQCW2yMZ4o-qv0dHno21s',
    appId: '1:927847752780:ios:27470916b99bbf8197c0e9',
    messagingSenderId: '927847752780',
    projectId: 'uas-catfish-project',
    storageBucket: 'uas-catfish-project.firebasestorage.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBR1RRYXFJ8puOQCW2yMZ4o-qv0dHno21s',
    appId: '1:927847752780:macos:27470916b99bbf8197c0e9',
    messagingSenderId: '927847752780',
    projectId: 'uas-catfish-project',
    storageBucket: 'uas-catfish-project.firebasestorage.app',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBR1RRYXFJ8puOQCW2yMZ4o-qv0dHno21s',
    appId: '1:927847752780:windows:27470916b99bbf8197c0e9',
    messagingSenderId: '927847752780',
    projectId: 'uas-catfish-project',
    storageBucket: 'uas-catfish-project.firebasestorage.app',
  );
}