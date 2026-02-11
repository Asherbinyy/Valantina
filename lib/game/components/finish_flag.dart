import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Finish flag — visual marker at the finish line (kFinishXTile).
/// Pole with a small triangular flag on top. No collision.
class FinishFlag extends PositionComponent {
  static const double _poleW = 4;
  static const double _poleH = 50;
  static const double _flagW = 20;
  static const double _flagH = 14;

  final Paint _polePaint = Paint()..color = const Color(0xFF8B6B4A);
  final Paint _flagPaint = Paint()..color = const Color(0xFFFF2D6F);

  FinishFlag()
      : super(
          position: Vector2(
            kFinishXTile * kTileSize + kTileSize / 2 - _poleW / 2,
            kGroundY - _poleH,
          ),
          size: Vector2(_poleW + _flagW, _poleH),
          priority: -1, // behind player
        );

  @override
  void render(Canvas canvas) {
    // Pole
    canvas.drawRect(
      Rect.fromLTWH(0, 0, _poleW, _poleH),
      _polePaint,
    );
    // Flag (triangle attached to top of pole)
    final flag = Path()
      ..moveTo(_poleW, 2)
      ..lineTo(_poleW + _flagW, 2 + _flagH / 2)
      ..lineTo(_poleW, 2 + _flagH)
      ..close();
    canvas.drawPath(flag, _flagPaint);
    // "END" text dot on flag (small circle)
    final dotPaint = Paint()..color = const Color(0xFFFFFFFF);
    canvas.drawCircle(
      Offset(_poleW + _flagW * 0.45, 2 + _flagH / 2),
      2.5,
      dotPaint,
    );
  }
}
