import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'package:all_about_music/screens/login.dart';
import 'package:all_about_music/screens/onboarding.dart';
import 'package:all_about_music/screens/signup.dart';
import 'package:all_about_music/screens/splash.dart';

class Routes {
  static final Map<String, Widget> routesMap = {
    '/': const SplashScreen(),
    '/login': const LoginScreen(),
    '/signup': const SignupScreen(),
    '/onboarding': const Onboarding(),
  };

  static final GoRouter router = GoRouter(
    routes: routesMap.entries.map((entry) {
      return GoRoute(
        path: entry.key,
        builder: (context, state) => entry.value,
      );
    }).toList(),
  );
}