import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:all_about_music/utils/colors.dart';

class BlurButton extends StatelessWidget {
  final VoidCallback onPressed;
  const BlurButton(this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(26),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: FilledButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.transparent),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(26),
                  side: const BorderSide(
                    color: grey,
                    width: 2,
                  ),
                ),
              ),
            ),
            onPressed: onPressed,
            child: const Text('LOGIN'),
          ),
        ),
      ),
    );
  }
}
