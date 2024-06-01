import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:all_about_music/routes.dart';
import 'firebase_options.dart';

// flutter emulators --launch Pixel_4_API_34
// firebase emulators:start --import ./emulators_data --export-on-exit

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  if (kDebugMode) {
    try {
      FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
      await FirebaseStorage.instance.useStorageEmulator('localhost', 9199);
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
      // print(Firebase.app().options);
    } catch (e) {
      print(e);
    }
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.router,
      debugShowCheckedModeBanner: false,
      title: 'All About Music',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFFC25325),
      ),
    );
  }
}
