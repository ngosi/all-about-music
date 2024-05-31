import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

class FanScreen extends StatelessWidget {
  const FanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => context.go('/onboarding'),
          child: const Text('Fan Area', style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
