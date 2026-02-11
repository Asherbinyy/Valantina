import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';
import 'heart.dart';
import 'obstacle.dart';

/// Player — sprite-based bunny with walk/jump/hurt/stand animations.
class Player extends PositionComponent
    with CollisionCallbacks, HasGameReference<RunToLoveGame> {
  // Physics
  final Vector2 velocity = Vector2.zero();
  bool isOnGround = true;

  // Hit recovery
  bool inRecovery = false;
  double _recoveryTimer = 0;
  double _blinkTimer = 0;

  // Cutscene flag — disables hazard collisions
  bool inCutscene = false;

  // Sprites
  late final Sprite _standSprite;
  late final Sprite _walkSprite;
  late final Sprite _jumpSprite;
  late final Sprite _hurtSprite;
  double _walkAnimTimer = 0;
  bool _useWalkFrame = false;

  Player()
      : super(
          position: Vector2(kPlayerStartX, kPlayerStartY),
          size: Vector2(kPlayerWidth, kPlayerHeight),
        );

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    _standSprite = Sprite(await Flame.images.load('sprites/player_stand.png'));
    _walkSprite = Sprite(await Flame.images.load('sprites/player_walk.png'));
    _jumpSprite = Sprite(await Flame.images.load('sprites/player_jump.png'));
    _hurtSprite = Sprite(await Flame.images.load('sprites/player_hurt.png'));
  }

  @override
  void update(double dt) {
    super.update(dt);
    final state = game.state.value;
    // During cutscene, player is frozen (no auto-run, no gravity).
    if (state != GameState.playing && state != GameState.hitRecovery) {
      return;
    }

    // Walk anim toggle
    _walkAnimTimer += dt;
    if (_walkAnimTimer >= 0.15) {
      _walkAnimTimer = 0;
      _useWalkFrame = !_useWalkFrame;
    }

    // Auto-run
    if (!inRecovery && !inCutscene) {
      position.x += kRunSpeed * dt;
    }

    // Gravity
    if (!inRecovery && !inCutscene) {
      velocity.y += kGravity * dt;
      velocity.y = min(velocity.y, kMaxFallSpeed);
      position.y += velocity.y * dt;
    }

    // Ground check — only if NOT over a gap
    final overGap = _isOverGap(position.x + size.x / 2);
    if (overGap) {
      // Falling into gap → trigger hit recovery
      if (position.y > kGroundY) {
        game.triggerHitRecovery();
      }
    } else if (position.y >= kGroundY - size.y) {
      position.y = kGroundY - size.y;
      velocity.y = 0;
      isOnGround = true;
    }

    if (inRecovery) {
      _recoveryTimer -= dt;
      _blinkTimer += dt;
      if (_recoveryTimer <= 0) {
        inRecovery = false;
        _recoveryTimer = 0;
        _blinkTimer = 0;
        game.finishHitRecovery();
      }
      return;
    }
  }

  @override
  void render(Canvas canvas) {
    // Blink during recovery
    if (inRecovery && (_blinkTimer * 10).floor() % 2 == 0) return;

    Sprite sprite;
    if (inRecovery) {
      sprite = _hurtSprite;
    } else if (!isOnGround) {
      sprite = _jumpSprite;
    } else if (_useWalkFrame) {
      sprite = _walkSprite;
    } else {
      sprite = _standSprite;
    }
    sprite.render(canvas, size: size);
  }

  void jump() {
    if (!isOnGround) return;
    velocity.y = kJumpVelocity;
    isOnGround = false;
    game.playJumpSfx();
  }

  void startRecovery() {
    inRecovery = true;
    _recoveryTimer = kHitRecoveryDuration;
    _blinkTimer = 0;

    velocity.setZero();
    isOnGround = true;
    position.y = kGroundY - size.y;

    final cpIndex = _checkpointIndex();
    position.x = kCheckpointXTiles[cpIndex] * kTileSize;
  }

  int _checkpointIndex() {
    for (int i = kCheckpointXTiles.length - 1; i >= 0; i--) {
      if (position.x >= kCheckpointXTiles[i] * kTileSize) return i;
    }
    return 0;
  }

  /// Returns true if the given world-X pixel is over a gap (no ground).
  bool _isOverGap(double worldX) {
    final tileX = worldX / kTileSize;
    for (final gap in kGapRanges) {
      if (tileX >= gap[0] && tileX <= gap[1]) return true;
    }
    return false;
  }

  void fullReset() {
    position
      ..x = kPlayerStartX
      ..y = kPlayerStartY;
    velocity.setZero();
    isOnGround = true;
    inRecovery = false;
    inCutscene = false;
    _recoveryTimer = 0;
    _blinkTimer = 0;
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
