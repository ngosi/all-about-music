import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final bool isOrange;
  const Button(this.onPressed, this.text, {super.key, this.isOrange = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: isOrange
            ? const [Color(0xFFC15324), Color(0xFF612A12)]
            : const [Color(0xFF404041), Color(0xFF252625)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: FilledButton(
              onPressed: onPressed,
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(const Size.fromHeight(60)),
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                    side: const BorderSide(
                      color: Color(0xFF707070),
                    ),
                  ),
                ),
              ),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
