import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Obstacle — spike (ground hazard) or bat (flying hazard).
/// Both trigger hitRecovery on contact.
class Obstacle extends PositionComponent {
  final ObstacleType type;

  late final Sprite _sprite;

  Obstacle({required int tileX, this.type = ObstacleType.spike})
      : super(
          position: Vector2(
            tileX * kTileSize + (kTileSize - _widthFor(type)) / 2,
            type == ObstacleType.bat
                ? kGroundY - kBatHeight - 50 // bats fly above ground
                : kGroundY - _heightFor(type),
          ),
          size: Vector2(_widthFor(type), _heightFor(type)),
        );

  static double _widthFor(ObstacleType t) {
    switch (t) {
      case ObstacleType.spike:
        return kSpikeWidth;
      case ObstacleType.bat:
        return kBatWidth;
    }
  }

  static double _heightFor(ObstacleType t) {
    switch (t) {
      case ObstacleType.spike:
        return kSpikeHeight;
      case ObstacleType.bat:
        return kBatHeight;
    }
  }

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    switch (type) {
      case ObstacleType.spike:
        _sprite = Sprite(await Flame.images.load('sprites/spikes_top.png'));
      case ObstacleType.bat:
        _sprite = Sprite(await Flame.images.load('sprites/bat1.png'));
    }
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
  }
}
