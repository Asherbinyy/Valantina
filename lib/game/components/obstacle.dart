import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Obstacle — 3 visual types, all trigger hitRecovery on contact.
/// Types: spike (triangle), tallSpike (tall triangle), rock (rounded boulder).
class Obstacle extends PositionComponent {
  final ObstacleType type;

  final Paint _paint = Paint()..color = const Color(0xFF2B2233);

  Obstacle({required int tileX, this.type = ObstacleType.spike})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - _widthFor(type)) / 2,
            kGroundY - _heightFor(type),
          ),
          size: Vector2(_widthFor(type), _heightFor(type)),
        );

  static double _widthFor(ObstacleType t) {
    switch (t) {
      case ObstacleType.spike:
        return kSpikeWidth;
      case ObstacleType.tallSpike:
        return kTallSpikeWidth;
      case ObstacleType.rock:
        return kRockWidth;
    }
  }

  static double _heightFor(ObstacleType t) {
    switch (t) {
      case ObstacleType.spike:
        return kSpikeHeight;
      case ObstacleType.tallSpike:
        return kTallSpikeHeight;
      case ObstacleType.rock:
        return kRockHeight;
    }
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
  }

  @override
  void render(Canvas canvas) {
    switch (type) {
      case ObstacleType.spike:
        _renderSpike(canvas);
      case ObstacleType.tallSpike:
        _renderTallSpike(canvas);
      case ObstacleType.rock:
        _renderRock(canvas);
    }
  }

  /// Standard spike — triangle pointing up.
  void _renderSpike(Canvas canvas) {
    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..lineTo(0, size.y)
      ..close();
    canvas.drawPath(path, _paint);
  }

  /// Tall spike — thinner, taller triangle (requires full jump).
  void _renderTallSpike(Canvas canvas) {
    final path = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, size.y)
      ..lineTo(0, size.y)
      ..close();
    canvas.drawPath(path, _paint);
    // Warning stripes
    final stripePaint = Paint()..color = const Color(0xFFFF4444);
    canvas.drawRect(
      Rect.fromLTWH(size.x * 0.3, size.y * 0.6, size.x * 0.4, 3),
      stripePaint,
    );
  }

  /// Rock — rounded, wider boulder (easy to jump, visual variety).
  void _renderRock(Canvas canvas) {
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), Radius.circular(size.y * 0.4)),
      _paint,
    );
    // Highlight
    final highlightPaint = Paint()
      ..color = const Color(0xFF4A4255);
    canvas.drawOval(
      Rect.fromLTWH(
        size.x * 0.2,
        size.y * 0.15,
        size.x * 0.3,
        size.y * 0.3,
      ),
      highlightPaint,
    );
  }
}
