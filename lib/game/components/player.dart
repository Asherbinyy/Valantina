import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';
import 'heart.dart';
import 'obstacle.dart';

/// Player cat — auto-runs right, tap to jump, gravity, ground/gap checks.
class Player extends PositionComponent
    with CollisionCallbacks, HasGameReference<RunToLoveGame> {
  final Vector2 velocity = Vector2.zero();
  bool isOnGround = false;
  int lastCheckpointIndex = -1;

  // Hit recovery
  bool inRecovery = false;
  double _recoveryTimer = 0;
  double _blinkTimer = 0;

  // Cutscene flag — disables hazard collisions
  bool inCutscene = false;

  // Visuals (placeholder)
  final Paint _paint = Paint()..color = const Color(0xFFFF8C42);
  final Paint _blinkPaint = Paint();
  final Paint _eyePaint = Paint()..color = const Color(0xFF2B2233);

  Player()
      : super(
          position: Vector2(kPlayerStartX, kPlayerStartY),
          size: Vector2(kPlayerWidth, kPlayerHeight),
        );

  @override
  Future<void> onLoad() async {
    // Hitbox slightly smaller than sprite — PROJECT_RULES.md §3
    add(RectangleHitbox(
      size: Vector2(size.x * 0.7, size.y * 0.8),
      position: Vector2(size.x * 0.15, size.y * 0.1),
    ));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final state = game.state.value;
    // During cutscene, player is frozen (no auto-run, no gravity).
    // Game handles deterministic snap positioning.
    if (state != GameState.playing && state != GameState.hitRecovery) {
      return;
    }

    // Hit recovery countdown
    if (inRecovery) {
      _recoveryTimer -= dt;
      _blinkTimer += dt;
      if (_recoveryTimer <= 0) {
        _finishRecovery();
      }
      return; // freeze position during recovery
    }

    // Auto-run
    position.x += kRunSpeed * dt;

    // Gravity
    velocity.y += kGravity * dt;
    velocity.y = min(velocity.y, kMaxFallSpeed);
    position.y += velocity.y * dt;

    // Ground check
    if (_isOverGround()) {
      if (position.y + height >= kGroundY) {
        position.y = kGroundY - height;
        velocity.y = 0;
        isOnGround = true;
      }
    } else {
      isOnGround = false;
      if (position.y > kGroundY + kGapFallThreshold) {
        game.triggerHitRecovery();
      }
    }

    // Track checkpoints
    _updateCheckpoint();
  }

  @override
  void render(Canvas canvas) {
    final Paint p;
    if (inRecovery) {
      final visible = (_blinkTimer * 8).floor() % 2 == 0;
      _blinkPaint.color =
          visible ? const Color(0xFFFF4444) : const Color(0x40FF8C42);
      p = _blinkPaint;
    } else {
      p = _paint;
    }
    canvas.drawRRect(
      RRect.fromRectAndRadius(size.toRect(), const Radius.circular(4)),
      p,
    );
    // Eyes
    canvas.drawCircle(Offset(size.x * 0.3, size.y * 0.35), 3, _eyePaint);
    canvas.drawCircle(Offset(size.x * 0.7, size.y * 0.35), 3, _eyePaint);
  }

  // ── Actions ──────────────────────────────────────────

  void jump({bool boost = false}) {
    if (isOnGround && !inRecovery) {
      velocity.y =
          boost ? kJumpVelocity * kBoostJumpMultiplier : kJumpVelocity;
      isOnGround = false;
    }
  }

  void startRecovery() {
    inRecovery = true;
    _recoveryTimer = kHitRecoveryDuration;
    _blinkTimer = 0;
  }

  void fullReset() {
    position
      ..x = kPlayerStartX
      ..y = kPlayerStartY;
    velocity.setZero();
    isOnGround = true;
    lastCheckpointIndex = -1;
    inRecovery = false;
    inCutscene = false;
    _recoveryTimer = 0;
    _blinkTimer = 0;
  }

  // ── Internals ────────────────────────────────────────

  void _finishRecovery() {
    inRecovery = false;
    _blinkTimer = 0;
    final double x = lastCheckpointIndex < 0
        ? kPlayerStartX
        : kCheckpointXTiles[lastCheckpointIndex] * kTileSize;
    position
      ..x = x
      ..y = kPlayerStartY;
    velocity.setZero();
    isOnGround = true;
    game.finishHitRecovery();
  }

  bool _isOverGround() {
    final centerX = position.x + width / 2;
    final tileX = (centerX / kTileSize).floor();
    for (final gap in kGapRanges) {
      if (tileX >= gap[0] && tileX <= gap[1]) return false;
    }
    return tileX >= 0 && tileX < kTotalTilesX;
  }

  void _updateCheckpoint() {
    for (int i = kCheckpointXTiles.length - 1; i >= 0; i--) {
      if (position.x >= kCheckpointXTiles[i] * kTileSize) {
        if (i > lastCheckpointIndex) lastCheckpointIndex = i;
        break;
      }
    }
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Heart) {
      other.collect();
    } else if (other is Obstacle && !inRecovery && !inCutscene) {
      game.triggerHitRecovery();
    }
  }
}
