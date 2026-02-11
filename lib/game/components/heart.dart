import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';

/// Heart collectible — varied heights per tier, pop + fade on collect.
class Heart extends PositionComponent
    with CollisionCallbacks, HasGameReference<RunToLoveGame> {
  bool collected = false;
  double _animTimer = 0;

  final Paint _paint = Paint()..color = const Color(0xFFFF2D6F);

  Heart({required int tileX, HeartTier tier = HeartTier.low})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - kHeartSize) / 2,
            kGroundY - _heightForTier(tier),
          ),
          size: Vector2(kHeartSize, kHeartSize),
          anchor: Anchor.center,
        );

  static double _heightForTier(HeartTier tier) {
    switch (tier) {
      case HeartTier.ground:
        return kHeartHeightGround;
      case HeartTier.low:
        return kHeartHeightLow;
      case HeartTier.high:
        return kHeartHeightHigh;
      case HeartTier.boost:
        return kHeartHeightBoost;
    }
  }

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

    if (progress < 0.5) {
      final s = 1.0 + progress * 1.5;
      scale = Vector2.all(s);
    } else {
      final fadeProgress = (progress - 0.5) / 0.5;
      _paint.color = Color(0xFFFF2D6F).withValues(alpha: 1.0 - fadeProgress);
    }

    if (progress >= 1.0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
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
    if (collected) return;
    collected = true;
    _animTimer = 0;
    game.onHeartCollected();
  }
}
