import 'package:flutter/material.dart';

class DiagonalContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final BoxDecoration? decoration;
  const DiagonalContainer({required this.child, this.height, this.decoration, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DiagonalPainter(),
      child: ClipPath(
        clipper: DiagonalClipper(),
        child: Container(
          height: height,
          decoration: decoration,
          child: child,
        ),
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path()
      ..lineTo(95, 86)
      ..lineTo(size.width, 86)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class DiagonalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var path = Path()
      ..moveTo(-9.6, -8.6)
      ..lineTo(95, 86)
      ..lineTo(size.width, 86);

    var paint = Paint()
      ..color = const Color(0xFFC25325)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
