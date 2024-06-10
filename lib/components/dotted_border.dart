import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class DottedBorder extends StatelessWidget {
  final Widget child;
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final Radius radius;
  final PathBuilder? customPath;

  const DottedBorder({
    super.key,
    required this.child,
    this.strokeWidth = 1,
    this.dashPattern = const [3, 1],
    this.color = Colors.black,
    this.radius = const Radius.circular(0),
    this.customPath,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: CustomDashedPainter(
                strokeWidth: strokeWidth,
                dashPattern: dashPattern,
                color: color,
                radius: radius,
                customPath: customPath,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

typedef PathBuilder = Path Function(Size);

class CustomDashedPainter extends CustomPainter {
  final double strokeWidth;
  final List<double> dashPattern;
  final Color color;
  final Radius radius;
  final StrokeCap strokeCap;
  final PathBuilder? customPath;

  CustomDashedPainter({
    this.strokeWidth = 1,
    this.dashPattern = const [3, 1],
    this.color = Colors.black,
    this.radius = const Radius.circular(0),
    this.strokeCap = StrokeCap.butt,
    this.customPath,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..strokeCap = strokeCap
      ..color = color
      ..style = PaintingStyle.stroke;

    Path path = (customPath == null) ? getPath(size) : dashPath(
      customPath!(size),
      dashArray: CircularIntervalList(dashPattern),
    );

    canvas.drawPath(path, paint);
  }

  Path getPath(Size size) {
    Path path;
    if (radius.x == 0) {
      path = Path()
        ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));
    } else {
      path = Path()
        ..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            radius,
          ),
        );
    }
    return dashPath(path, dashArray: CircularIntervalList(dashPattern));
  }

  @override
  bool shouldRepaint(CustomDashedPainter oldDelegate) => false;
}
