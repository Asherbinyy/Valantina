import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';

/// Heart collectible — pop + fade animation on collect.
class Heart extends PositionComponent
    with CollisionCallbacks, HasGameReference<RunToLoveGame> {
  bool collected = false;
  double _animTimer = 0;

  // Visual
  final Paint _paint = Paint()..color = const Color(0xFFFF2D6F); // HEART color

  Heart({required int tileX})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - kHeartSize) / 2,
            kGroundY - kHeartFloatAboveGround,
          ),
          size: Vector2(kHeartSize, kHeartSize),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox(isSolid: true));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!collected) {
      // Gentle bob
      position.y += sin(game.elapsedGameTime() * 3) * 0.15;
      return;
    }

    // Pop + fade animation
    _animTimer += dt;
    final progress = (_animTimer / kHeartPopDuration).clamp(0.0, 1.0);

    // First half: scale up   Second half: fade out
    if (progress < 0.5) {
      final s = 1.0 + progress * 1.5; // scale 1→1.75
      scale = Vector2.all(s);
    } else {
      final fadeProgress = (progress - 0.5) / 0.5; // 0→1
      _paint.color = Color(0xFFFF2D6F).withValues(alpha: 1.0 - fadeProgress);
    }

    if (progress >= 1.0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    // Draw a heart shape
    final w = size.x;
    final h = size.y;
    final path = Path()
      ..moveTo(w / 2, h * 0.35)
      ..cubicTo(w * 0.15, 0, 0, h * 0.4, w / 2, h)
      ..moveTo(w / 2, h * 0.35)
      ..cubicTo(w * 0.85, 0, w, h * 0.4, w / 2, h);
    canvas.drawPath(path, _paint);
  }

  void collect() {
    if (collected) return; // prevent double-collect
    collected = true;
    _animTimer = 0;
    game.onHeartCollected();
  }
}
