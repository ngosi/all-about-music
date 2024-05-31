import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';

import 'package:all_about_music/components/button.dart';
import 'package:all_about_music/components/diagonal_container.dart';
import 'package:all_about_music/components/diagonal_container_contents.dart';

class AccountTypeScreen extends StatelessWidget {
  const AccountTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DiagonalContainer(
          doubleBorder: true,
          child: DiagonalContainerContents(
            doubleBorder: true,
            hasLine: false,
            contents: [
              Button(
                () => context.go('/artist'),
                "I'M AN ARTIST",
                fillOrange: false,
                borderColor: const Color(0xFFE88B38),
              ),
              const SizedBox(height: 20),
              Button(
                () => context.go('/fan'),
                "I'M A FAN",
                fillOrange: false,
                borderColor: const Color(0xFFFFBF68),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
