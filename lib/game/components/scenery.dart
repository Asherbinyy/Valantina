import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Decorative scenery — sprite-based, no collision, renders behind player.
/// Types: grass1, grass2, mushroomRed, mushroomBrown, cactus.
class Scenery extends PositionComponent {
  final SceneryType type;
  late final Sprite _sprite;

  Scenery({required int tileX, required this.type})
      : super(
          position: Vector2(
            tileX * kTileSize,
            kGroundY - _heightFor(type),
          ),
          size: Vector2(_widthFor(type), _heightFor(type)),
          priority: -1, // render behind player
        );

  static double _widthFor(SceneryType t) {
    switch (t) {
      case SceneryType.grass1:
        return 20.0;
      case SceneryType.grass2:
        return 28.0;
      case SceneryType.mushroomRed:
        return 24.0;
      case SceneryType.mushroomBrown:
        return 24.0;
      case SceneryType.cactus:
        return 22.0;
    }
  }

  static double _heightFor(SceneryType t) {
    switch (t) {
      case SceneryType.grass1:
        return 20.0;
      case SceneryType.grass2:
        return 24.0;
      case SceneryType.mushroomRed:
        return 30.0;
      case SceneryType.mushroomBrown:
        return 25.0;
      case SceneryType.cactus:
        return 40.0;
    }
  }

  static String _spriteFor(SceneryType t) {
    switch (t) {
      case SceneryType.grass1:
        return 'sprites/grass1.png';
      case SceneryType.grass2:
        return 'sprites/grass2.png';
      case SceneryType.mushroomRed:
        return 'sprites/mushroom_red.png';
      case SceneryType.mushroomBrown:
        return 'sprites/mushroom_brown.png';
      case SceneryType.cactus:
        return 'sprites/cactus.png';
    }
  }

  @override
  Future<void> onLoad() async {
    _sprite = Sprite(await Flame.images.load(_spriteFor(type)));
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
  }
}
