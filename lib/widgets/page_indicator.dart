import 'package:flutter/material.dart';

class PageIndicator extends StatefulWidget {
  final int index;
  final int length;
  const PageIndicator(this.index, this.length, {super.key});

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(widget.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(index == widget.index ? 0xFFC25325 : 0xFF434343),
              border: Border.all(
                color: const Color(0xFF707070),
              ),
            ),
            width: 12,
            height: 12,
          ),
        );
      }),
    );
  }
}
