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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAJWWI1sGMyddRr6KOqPYGrB60T23toiho',
    appId: '1:160468269430:android:6fc00294dc948ed5712257',
    messagingSenderId: '160468269430',
    projectId: 'fury-chatbase',
    databaseURL: 'https://fury-chatbase.firebaseio.com',
    storageBucket: 'fury-chatbase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCDRQI3UFedPwem6ZvButGDKlyh-EAgoV4',
    appId: '1:160468269430:ios:970b8275fd688080712257',
    messagingSenderId: '160468269430',
    projectId: 'fury-chatbase',
    databaseURL: 'https://fury-chatbase.firebaseio.com',
    storageBucket: 'fury-chatbase.appspot.com',
    androidClientId: '160468269430-bgv5f231r0rhsfhl5vgmk6rdatv0jcmq.apps.googleusercontent.com',
    iosClientId: '160468269430-vhs55sesnj9gqcmgfrqneod22i1k563s.apps.googleusercontent.com',
    iosBundleId: 'tech.denysfernandes.lovedStore',
  );
}