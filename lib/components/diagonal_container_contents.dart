import 'package:flutter/material.dart';

class DiagonalContainerContents extends StatelessWidget {
  final List<Widget>? contents;
  final bool doubleBorder;
  final bool hasLine;
  const DiagonalContainerContents({
    this.contents,
    this.doubleBorder = false,
    this.hasLine = true,
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
