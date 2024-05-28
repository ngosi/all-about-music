import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DiagonalContainerContents extends StatelessWidget {
  final List<Widget>? contents;
  const DiagonalContainerContents({this.contents, super.key});

  @override
  Widget build(BuildContext context) {
    late List<Widget> modifiedContents = [];
    if (contents != null) {
      modifiedContents.add(const SizedBox(height: 116));
      modifiedContents.addAll(contents!);
    }
    return IntrinsicHeight(
      child: Row(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: VerticalDivider(color: Color(0xFFE88B38), thickness: .75),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: modifiedContents.isEmpty
                ? [Container()]
                : modifiedContents,
            ),
          ),
          const SizedBox(width: 18),
        ],
      ),
    );
  }
}
