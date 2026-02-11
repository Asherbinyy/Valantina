import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Queen Bunny — same visual scale as Player.
/// Stands at kQueenWorldX waiting for the player.
class Queen extends PositionComponent {
  late final Sprite _sprite;

  Queen()
      : super(
          position: Vector2(kQueenWorldX, kGroundY - kQueenHeight),
          size: Vector2(kQueenWidth, kQueenHeight),
        );

  @override
  Future<void> onLoad() async {
    _sprite = Sprite(await Flame.images.load('sprites/queen_stand.png'));
  }

  @override
  void render(Canvas canvas) {
    _sprite.render(canvas, size: size);
  }
}
