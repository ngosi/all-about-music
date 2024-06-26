import 'package:flutter/material.dart';

import 'package:all_about_music/utils/colors.dart';

class DiagonalContainerContents extends StatelessWidget {
  final List<Widget>? contents;
  final bool doubleBorder;
  final bool hasLine;
  final CrossAxisAlignment crossAxisAlignment;
  const DiagonalContainerContents({
    this.contents,
    this.doubleBorder = false,
    this.hasLine = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    late List<Widget> modifiedContents = [];
    if (contents != null) {
      modifiedContents.add(const SizedBox(height: 116));
      modifiedContents.addAll(contents!);
      if (doubleBorder) {
        modifiedContents.add(const SizedBox(height: 116));
      }
    }
    return IntrinsicHeight(
      child: hasLine
        ? Row(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: VerticalDivider(color: orange2, thickness: .75),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: crossAxisAlignment,
                children: modifiedContents.isEmpty
                  ? [Container()]
                  : modifiedContents,
              ),
            ),
            const SizedBox(width: 18),
          ],
        )
      : Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
        child: Column(
          children: modifiedContents.isEmpty
            ? [Container()]
            : modifiedContents,
        ),
      ),
    );
  }
}
