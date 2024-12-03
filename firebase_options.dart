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
    apiKey: 'AIzaSyBw3aLH9EiLoaPrIP9fuD_SOfrBFUb2f2o',
    appId: '1:743988437913:web:1e34869cbfad5d58d76908',
    messagingSenderId: '743988437913',
    projectId: 'gosehat-95087',
    authDomain: 'gosehat-95087.firebaseapp.com',
    storageBucket: 'gosehat-95087.firebasestorage.app',
    measurementId: 'G-58Z187T4ZX',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDQ0c_8GCc07AVYfamNP_4epvLDPpP7QUk',
    appId: '1:743988437913:android:6a9e6fd9b96cd942d76908',
    messagingSenderId: '743988437913',
    projectId: 'gosehat-95087',
    storageBucket: 'gosehat-95087.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAPZM5J_Ej5n2-X-k_dWI_1mkRJzhxWQ2k',
    appId: '1:743988437913:ios:809f897168598cbdd76908',
    messagingSenderId: '743988437913',
    projectId: 'gosehat-95087',
    storageBucket: 'gosehat-95087.firebasestorage.app',
    iosBundleId: 'com.example.untitled',
  );
}
