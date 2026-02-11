import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';

/// Heart collectible — sprite-based with pop + fade on collect.
class Heart extends PositionComponent
    with CollisionCallbacks, HasGameReference<RunToLoveGame> {
  bool collected = false;
  double _animTimer = 0;
  double _opacity = 1.0;

  late final Sprite _sprite;

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
    _sprite = Sprite(await Flame.images.load('sprites/heart.png'));
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
      _opacity = 1.0 - ((progress - 0.5) / 0.5);
    }

    if (progress >= 1.0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    if (_opacity < 1.0) {
      final paint = Paint()..color = Color.fromRGBO(255, 255, 255, _opacity);
      _sprite.render(canvas, size: size, overridePaint: paint);
    } else {
      _sprite.render(canvas, size: size);
    }
  }

  void collect() {
    if (collected) return;
    collected = true;
    _animTimer = 0;
    game.onHeartCollected();
  }
}
