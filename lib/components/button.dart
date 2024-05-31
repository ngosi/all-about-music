import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  final bool fillOrange;
  final Color borderColor;
  final bool textOrange;
  final double height;
  const Button(
    this.onPressed,
    this.text, {
      super.key,
      this.isLoading = false,
      this.fillOrange = true,
      this.borderColor = const Color(0xFF707070),
      this.textOrange = false,
      this.height = 60,
    }
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: fillOrange
            ? const [Color(0xFFC15324), Color(0xFF612A12)]
            : const [Color(0xFF404041), Color(0xFF252625)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: FilledButton(
          onPressed: onPressed,
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(height-34),
                side: BorderSide(
                  color: borderColor,
                ),
              ),
            ),
          ),
          child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(
                  color: textOrange ? const Color(0xFFE88B38) : Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
        ),
      ),
    );
  }
}
