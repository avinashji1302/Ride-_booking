import 'dart:math';
import 'package:flutter/material.dart';

class ScallopedStatusIcon extends StatelessWidget {
  final double size;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;

  const ScallopedStatusIcon({
    super.key,
    this.size = 10,
    required this.backgroundColor,
    required this.icon,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _ScallopedCirclePainter(
        color: backgroundColor,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: size * 0.45,
        ),
      ),
    );
  }
}

class _ScallopedCirclePainter extends CustomPainter {
  final Color color;

  _ScallopedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    const scallops = 10; // zig-zag count
    final angleStep = 2 * pi / scallops;

    for (int i = 0; i <= scallops; i++) {
      final angle = i * angleStep;
      final r = radius * (i.isEven ? 1 : 0.9);

      final x = center.dx + r * cos(angle);
      final y = center.dy + r * sin(angle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
