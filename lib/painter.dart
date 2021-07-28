import 'package:flutter/material.dart';

class Painter {
  static Paint paint({Color? color, PaintingStyle? style, double? strokeWidth}) {
    Paint p = Paint();
    if (color != null) p.color = color;
    if (style != null) p.style = style;
    if (strokeWidth != null) p.strokeWidth = strokeWidth;
    return p;
  }

  static void circleShader(Canvas canvas, Color centerColor, Color sideColor, Offset center, double radius) {
    Paint p = Paint()
      ..shader = RadialGradient(colors: [
        centerColor,
        sideColor,
      ]).createShader(Rect.fromCircle(
        center: center,
        radius: radius,
      ));
    canvas.drawCircle(center, radius, p);
  }

  static void shadow(Canvas canvas, Path path, double? elevation) {
    if (elevation != null && elevation > 0) canvas.drawShadow(path, Colors.grey.shade900, elevation, true);
  }

  static void circle(Canvas canvas, Offset center, double radius, Color color, [double? elevation]) {
    Path path = Path()..addOval(Rect.fromCircle(center: center, radius: radius));
    Painter.path(canvas, path, color, elevation);
  }

  static void ring(Canvas canvas, Offset center, double radius, double strokeWith, Color color, [double? elevation]) {
    Path path = Path.combine(
      PathOperation.difference,
      Path()..addOval(Rect.fromCircle(center: center, radius: radius + strokeWith / 2)),
      Path()..addOval(Rect.fromCircle(center: center, radius: radius - strokeWith / 2)),
    );

    Painter.path(canvas, path, color, elevation);
  }

  static void rRectBorder(Canvas canvas, Offset center, Size size, double radius, double borderWidth, Color color, [double? elevation]) {
    Path path = Path.combine(
      PathOperation.difference,
      Path()..addRRect(RRect.fromLTRBR(center.dx - size.width / 2 - borderWidth / 2, center.dy + size.height / 2 + borderWidth / 2, center.dx + size.width / 2 + borderWidth / 2, center.dy - size.height / 2 - borderWidth / 2, Radius.circular(radius + borderWidth / 2))),
      Path()..addRRect(RRect.fromLTRBR(center.dx - size.width / 2 + borderWidth / 2, center.dy + size.height / 2 - borderWidth / 2, center.dx + size.width / 2 - borderWidth / 2, center.dy - size.height / 2 + borderWidth / 2, Radius.circular(radius - borderWidth / 2))),
    );

    Painter.path(canvas, path, color, elevation);
  }

  static void rRect(Canvas canvas, Offset center, Size size, double radius, Color color, [double? elevation]) {
    Path path = Path()..addRRect(RRect.fromLTRBR(center.dx - size.width / 2, center.dy - size.height / 2, center.dx + size.width / 2, center.dy + size.height / 2, Radius.circular(radius)));
    Painter.path(canvas, path, color, elevation);
  }

  static void path(Canvas canvas, Path path, Color color, [double? elevation]) {
    Painter.shadow(canvas, path, elevation);
    canvas.drawPath(path, paint(color: color, style: PaintingStyle.fill));
  }
}
