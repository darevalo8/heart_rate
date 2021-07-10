import 'package:flutter/material.dart';

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.style = PaintingStyle.fill;
    // paint.style = PaintingStyle.stroke;

    // paint.strokeWidth = 15;

    var path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.30); //vertical line
    path.quadraticBezierTo(
        size.width / 2, size.height * 0, size.width, size.height * 0.30);
    path.lineTo(size.width, size.height);
    // path.quadraticBezierTo(size.width / 2, size.height, size.width,
    //     size.height * 0.70); //quadratic curve
    // path.lineTo(size.width, 0);
    // path.moveTo(0, size.height * 0.5);
    // path.quadraticBezierTo(
    //     size.width / 2, size.height, size.width, size.height * 0.26);
    // path.lineTo(size.width, 0);
    // path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
