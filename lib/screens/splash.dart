import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _loggedIn = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _loggedIn = user != null;
      });
    });
    Future.delayed(const Duration(seconds: 5), () {
      print(FirebaseAuth.instance.currentUser);
      context.go(_loggedIn ? '/profile' : '/onboarding');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('assets/images/splash.png'),
      fit: BoxFit.cover,
    );
  }
}
