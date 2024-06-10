import 'package:flutter/material.dart';

import 'package:all_about_music/utils/colors.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool fillOrange;
  final Color borderColor;
  final bool textOrange;
  final double height;
  final double width;
  final double? borderRadius;
  const Button(
    this.text,
    this.onPressed, {
      super.key,
      this.isLoading = false,
      this.fillOrange = true,
      this.borderColor = grey,
      this.textOrange = false,
      this.height = 60,
      this.width = double.infinity,
      this.borderRadius,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? height-34),
        gradient: LinearGradient(
          colors: fillOrange
            ? const [orange2, darkOrange]
            : const [darkGrey2, darkGrey4],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox(
        width: width,
        height: height,
        child: FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? height-34),
                side: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
          ),
          child: isLoading
            ? const CircularProgressIndicator(color: white)
            : FittedBox(
              child: Text(
                text,
                style: TextStyle(
                  color: textOrange ? lightOrange : white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
        ),
      ),
    );
  }
}
