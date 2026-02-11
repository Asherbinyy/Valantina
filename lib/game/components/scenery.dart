import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Decorative tree — no hitbox, no collision, renders behind player.
/// Simple trunk + triangular foliage.
class Tree extends PositionComponent {
  static const double _trunkW = 8;
  static const double _trunkH = 18;
  static const double _foliageW = 28;
  static const double _foliageH = 30;
  static const double _totalH = _trunkH + _foliageH;

  final Paint _trunkPaint = Paint()..color = const Color(0xFF8B6B4A);
  final Paint _foliagePaint = Paint()..color = const Color(0xFF5DAE6B);

  Tree({required int tileX})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - _foliageW) / 2,
            kGroundY - _totalH,
          ),
          size: Vector2(_foliageW, _totalH),
          priority: -1, // render behind player
        );

  @override
  void render(Canvas canvas) {
    // Trunk (centered at bottom)
    final trunkX = (size.x - _trunkW) / 2;
    canvas.drawRect(
      Rect.fromLTWH(trunkX, _foliageH, _trunkW, _trunkH),
      _trunkPaint,
    );
    // Foliage (triangle)
    final foliage = Path()
      ..moveTo(size.x / 2, 0)
      ..lineTo(size.x, _foliageH)
      ..lineTo(0, _foliageH)
      ..close();
    canvas.drawPath(foliage, _foliagePaint);
  }
}

/// Decorative bush — no hitbox, no collision, renders behind player.
/// Small rounded green shape on the ground.
class Bush extends PositionComponent {
  static const double _w = 22;
  static const double _h = 14;

  final Paint _paint = Paint()..color = const Color(0xFF4A9E5A);

  Bush({required int tileX})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - _w) / 2,
            kGroundY - _h,
          ),
          size: Vector2(_w, _h),
          priority: -1, // render behind player
        );

  @override
  void render(Canvas canvas) {
    // Two overlapping circles for a bushy shape
    canvas.drawOval(
      Rect.fromLTWH(0, _h * 0.2, _w * 0.65, _h * 0.8),
      _paint,
    );
    canvas.drawOval(
      Rect.fromLTWH(_w * 0.35, 0, _w * 0.65, _h),
      _paint,
    );
  }
}
