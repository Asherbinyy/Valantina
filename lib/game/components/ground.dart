import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Ground segment — sprite-based tileable ground.
class GroundSegment extends PositionComponent {
  late final Sprite _sprite;

  GroundSegment({required int startTile, required int endTile})
      : super(
          position: Vector2(startTile * kTileSize, kGroundY),
          size: Vector2(
              (endTile - startTile + 1) * kTileSize, kGroundThickness),
        );

  @override
  Future<void> onLoad() async {
    _sprite = Sprite(await Flame.images.load('tiles/ground.png'));
  }

  @override
  void render(Canvas canvas) {
    // Tile the ground sprite across the full width
    final spriteW = _sprite.srcSize.x;
    final spriteH = _sprite.srcSize.y;
    final scaleY = size.y / spriteH;
    final tileW = spriteW * scaleY; // maintain aspect ratio

    double x = 0;
    while (x < size.x) {
      final drawW = (x + tileW > size.x) ? size.x - x : tileW;
      _sprite.render(
        canvas,
        position: Vector2(x, 0),
        size: Vector2(drawW, size.y),
      );
      x += tileW;
    }
  }
}
