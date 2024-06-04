import 'package:all_about_music/utils/colors.dart';
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
              color: index == widget.index ? orange : darkGrey,
              border: Border.all(
                color: grey,
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
