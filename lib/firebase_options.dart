// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCvEv_wOKfTnsUjz1fFFXllo525cHpOdW8',
    appId: '1:363029929800:web:7fbf1e4708b1cd6a359d7d',
    messagingSenderId: '363029929800',
    projectId: 'all-about-music-3d4ae',
    authDomain: 'all-about-music-3d4ae.firebaseapp.com',
    storageBucket: 'all-about-music-3d4ae.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBsn02RiRLIBTxoN8OacUoPxO4iUsqepIk',
    appId: '1:363029929800:android:92dcfd927c68b962359d7d',
    messagingSenderId: '363029929800',
    projectId: 'all-about-music-3d4ae',
    storageBucket: 'all-about-music-3d4ae.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuv9LSVb5TjbdX-ONEMqDTjUJOLqn08ZA',
    appId: '1:363029929800:ios:1d7d785d3999dc5f359d7d',
    messagingSenderId: '363029929800',
    projectId: 'all-about-music-3d4ae',
    storageBucket: 'all-about-music-3d4ae.appspot.com',
    iosBundleId: 'com.lindstudios.allAboutMusic',
  );

}