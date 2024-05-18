import 'package:flutter/material.dart';

import 'package:all_about_music/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
