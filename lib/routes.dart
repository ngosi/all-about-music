import 'package:all_about_music/screens/song.dart';
import 'package:flutter/widgets.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/screens/account_type.dart';
import 'package:all_about_music/screens/artist_signup.dart';
import 'package:all_about_music/screens/upload_demo.dart';
import 'package:all_about_music/screens/login.dart';
import 'package:all_about_music/screens/onboarding.dart';
import 'package:all_about_music/screens/signup.dart';
import 'package:all_about_music/screens/splash.dart';
import 'package:all_about_music/screens/navbar.dart';

class Routes {
  static final Map<String, Widget> routesMap = {
    '/': const SplashScreen(),
    '/login': const LoginScreen(),
    '/signup': const SignupScreen(),
    '/onboarding': const Onboarding(),
    '/accountType': const AccountTypeScreen(),
    '/artist': const ArtistSignupScreen(),
    '/profile': const NavBarScreen(0),
    '/uploadDemo': const UploadDemoScreen(),
    '/home': const NavBarScreen(1),
    '/roundtable': const NavBarScreen(2),
    '/settings': const NavBarScreen(3),
  };

  static final GoRouter router = GoRouter(
    routes: routesMap.entries.map((entry) {
      return GoRoute(
        path: entry.key,
        builder: (context, state) => entry.value,
      );
    }).toList() + [
      GoRoute(
        path: '/song/:songId',
        builder: (context, state) => SongScreen(state.pathParameters['songId']!),
      ),
    ],
  );
}