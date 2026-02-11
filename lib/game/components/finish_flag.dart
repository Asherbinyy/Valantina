import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

/// Finish door — 2×2 grid of door tile sprites.
/// Placed behind the characters, opens during cutscene.
class FinishDoor extends PositionComponent {
  late final Sprite _topLeft;
  late final Sprite _topRight;
  late final Sprite _bottomLeft;
  late final Sprite _bottomRight;

  FinishDoor()
      : super(
          position: Vector2(kDoorWorldX, kDoorWorldY),
          size: Vector2(kDoorWidth, kDoorHeight),
          priority: -1, // behind characters
        );

  @override
  Future<void> onLoad() async {
    _topLeft = Sprite(await Flame.images.load('sprites/door_top_left.png'));
    _topRight = Sprite(await Flame.images.load('sprites/door_top_right.png'));
    _bottomLeft = Sprite(await Flame.images.load('sprites/door_bottom_left.png'));
    _bottomRight = Sprite(await Flame.images.load('sprites/door_bottom_right.png'));
  }

  @override
  void render(Canvas canvas) {
    final halfW = size.x / 2;
    final halfH = size.y / 2;
    _topLeft.render(canvas, position: Vector2.zero(), size: Vector2(halfW, halfH));
    _topRight.render(canvas, position: Vector2(halfW, 0), size: Vector2(halfW, halfH));
    _bottomLeft.render(canvas, position: Vector2(0, halfH), size: Vector2(halfW, halfH));
    _bottomRight.render(canvas, position: Vector2(halfW, halfH), size: Vector2(halfW, halfH));
  }
}
