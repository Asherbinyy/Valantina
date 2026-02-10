import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Queen Cat — same visual scale as Player, placed at kQueenXTile.
/// Placeholder: pink rounded rect with gold crown, eyes, and smile.
class Queen extends PositionComponent {
  final Paint _paint = Paint()..color = const Color(0xFFFF7FB0); // yesHi pink
  final Paint _crownPaint = Paint()..color = const Color(0xFFFFD700); // gold
  final Paint _eyePaint = Paint()..color = const Color(0xFF2B2233);

  Queen()
      : super(
          position: Vector2(kQueenWorldX, kGroundY - kQueenHeight),
          size: Vector2(kQueenWidth, kQueenHeight),
        );

  @override
  void render(Canvas canvas) {
    // Body (rounded rect — same shape as player)
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(4)),
      _paint,
    );
    // Crown (small triangle on top)
    final crownPath = Path()
      ..moveTo(size.x * 0.15, 3)
      ..lineTo(size.x * 0.5, -5)
      ..lineTo(size.x * 0.85, 3)
      ..close();
    canvas.drawPath(crownPath, _crownPaint);
    // Eyes (same proportions as player)
    canvas.drawCircle(Offset(size.x * 0.3, size.y * 0.35), 3, _eyePaint);
    canvas.drawCircle(Offset(size.x * 0.7, size.y * 0.35), 3, _eyePaint);
    // Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF2B2233)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawArc(
      Rect.fromLTWH(size.x * 0.3, size.y * 0.55, size.x * 0.4, size.y * 0.15),
      0,
      3.14,
      false,
      smilePaint,
    );
  }
}
