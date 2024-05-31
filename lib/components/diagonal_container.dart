import 'package:flutter/material.dart';

import 'package:all_about_music/components/diagonal_container_contents.dart';

class DiagonalContainer extends StatelessWidget {
  final Widget child;
  final List<Widget>? contents;
  final double? height;
  final BoxDecoration decoration;
  final bool defaultBorder;
  final bool doubleBorder;
  const DiagonalContainer({
    this.child = const DiagonalContainerContents(),
    this.contents,
    this.height,
    this.decoration = const BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF404041), Color(0xFF0E0F0E)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
    ),
    this.defaultBorder = true,
    this.doubleBorder = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalPainter(defaultBorder, doubleBorder),
      child: ClipPath(
        clipper: DiagonalClipper(doubleBorder),
        child: Container(
          height: height,
          decoration: decoration,
          child: contents == null
            ? child
            : DiagonalContainerContents(contents: contents),
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  final bool doubleBorder;
  DiagonalClipper(this.doubleBorder);

  @override
  Path getClip(Size size) {
    late Path path;
    if (doubleBorder) {
      path = Path()
        ..lineTo(95, 86)
        ..lineTo(size.width, 86)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width - 95, size.height - 86)
        ..lineTo(0, size.height - 86)
        ..close();
    } else {
      path = Path()
        ..lineTo(95, 86)
        ..lineTo(size.width, 86)
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();
    }

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DiagonalPainter extends CustomPainter {
  final bool defaultBorder;
  final bool doubleBorder;
  const DiagonalPainter(this.defaultBorder, this.doubleBorder);

  @override
  void paint(Canvas canvas, Size size) {
    if (defaultBorder) {
      Path path = Path()
        ..moveTo(-9.5, -8.6)
        ..lineTo(95, 86)
        ..lineTo(size.width, 86);
      Paint paint = Paint()
        ..color = const Color(0xFFC25325)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10;

      canvas.drawPath(path, paint);
      if (doubleBorder) {
        path = Path()
          ..moveTo(size.width + 9.5, size.height + 8.6)
          ..lineTo(size.width - 95, size.height - 86)
          ..lineTo(0, size.height - 86);

        canvas.drawPath(path, paint);
      }
    } else {
      Path path = Path()
        ..moveTo(-3, -13)
        ..lineTo(98, 80);
      Paint paint = Paint()
        ..color = const Color(0xFF707070)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 14;

      canvas.drawPath(path, paint);

      path.lineTo(size.width, 80);
      paint.strokeWidth = 13;

      canvas.drawPath(path, paint);

      path = Path()
        ..moveTo(-3, -13)
        ..lineTo(98, 80);
      paint = Paint()
        ..color = const Color(0xFFE88B38)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 11;

      canvas.drawPath(path, paint);

      path.lineTo(size.width, 80);
      paint.strokeWidth = 9;

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
