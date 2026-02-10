import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Spike obstacle — placeholder triangle with hitbox.
class Obstacle extends PositionComponent {
  final Paint _paint = Paint()..color = const Color(0xFF2B2233);

  Obstacle({required int tileX})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - kSpikeWidth) / 2,
            kGroundY - kSpikeHeight,
          ),
          size: Vector2(kSpikeWidth, kSpikeHeight),
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..lineTo(0, size.y)
      ..close();
    canvas.drawPath(path, _paint);
  }
}
