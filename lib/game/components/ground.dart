import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Visual-only ground segment (collision is manual in Player).
class GroundSegment extends PositionComponent {
  final Paint _earthPaint = Paint()..color = const Color(0xFF8B6F47);
  final Paint _grassPaint = Paint()..color = const Color(0xFF4CAF50);

  GroundSegment({required int startTile, required int endTile})
      : super(
          position: Vector2(startTile * kTileSize, kGroundY),
          size: Vector2(
            (endTile - startTile + 1) * kTileSize,
            kGroundThickness,
          ),
        );

  @override
  void render(Canvas canvas) {
    canvas.drawRect(size.toRect(), _earthPaint);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 6), _grassPaint);
  }
}
