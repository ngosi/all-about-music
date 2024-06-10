import 'package:all_about_music/utils/colors.dart';
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
      body: Stack(
        children: [
          const Image(image: AssetImage('assets/images/artist.png')),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Image(
              image: AssetImage('assets/images/fan.png'),
              fit: BoxFit.fitWidth,
            ),
          ),
          Center(
            child: DiagonalContainer(
              doubleBorder: true,
              child: DiagonalContainerContents(
                doubleBorder: true,
                hasLine: false,
                contents: [
                  Button(
                    "I'M AN ARTIST",
                    () => context.go('/artist'),
                    fillOrange: false,
                    borderColor: lightOrange,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    "I'M A FAN",
                    () => context.go('/profile'),
                    fillOrange: false,
                    borderColor: yellow,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
