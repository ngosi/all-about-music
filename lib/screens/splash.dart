import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // FirebaseAuth.instance.signOut();
      if (FirebaseAuth.instance.currentUser == null) {
        context.go('/onboarding');
      } else {
        context.go('/profile');
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/images/splash.png'),
      fit: BoxFit.cover,
    );
  }
}
