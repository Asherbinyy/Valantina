import 'dart:math';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../run_to_love_game.dart';

/// Heart particle burst — spawned during finish cutscene.
/// Simple floating hearts that drift upward and fade out.
class HeartParticles extends Component with HasGameReference<RunToLoveGame> {
  final Random _rng = Random();
  double _timer = 0;
  final List<_HeartParticle> _particles = [];
  bool _spawning = true;

  HeartParticles();

  @override
  void update(double dt) {
    super.update(dt);
    _timer += dt;

    // Spawn particles for the first portion of the duration
    if (_spawning && _timer < kHeartParticleDuration * 0.6) {
      // Spawn 2-3 per frame
      for (int i = 0; i < 2 + _rng.nextInt(2); i++) {
        _particles.add(_HeartParticle(
          x: game.player.position.x + _rng.nextDouble() * 80 - 40,
          y: game.player.position.y - _rng.nextDouble() * 20,
          vx: (_rng.nextDouble() - 0.5) * 40,
          vy: -30 - _rng.nextDouble() * 60,
          size: 6 + _rng.nextDouble() * 10,
          life: 1.0 + _rng.nextDouble() * 1.5,
        ));
      }
    } else {
      _spawning = false;
    }

    // Update particles
    for (final p in _particles) {
      p.x += p.vx * dt;
      p.y += p.vy * dt;
      p.age += dt;
    }
    _particles.removeWhere((p) => p.age >= p.life);

    // Remove self when done
    if (!_spawning && _particles.isEmpty) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    for (final p in _particles) {
      final alpha = ((1.0 - p.age / p.life) * 255).clamp(0, 255).toInt();
      final paint = Paint()..color = Color.fromARGB(alpha, 255, 45, 111);
      _drawHeart(canvas, p.x, p.y, p.size, paint);
    }
  }

  void _drawHeart(Canvas canvas, double cx, double cy, double s, Paint paint) {
    final path = Path()
      ..moveTo(cx, cy + s * 0.35)
      ..cubicTo(cx - s * 0.35, cy, cx - s * 0.5, cy + s * 0.4, cx, cy + s)
      ..moveTo(cx, cy + s * 0.35)
      ..cubicTo(cx + s * 0.35, cy, cx + s * 0.5, cy + s * 0.4, cx, cy + s);
    canvas.drawPath(path, paint);
  }
}

class _HeartParticle {
  double x, y, vx, vy, size, life, age;
  _HeartParticle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.size,
    required this.life,
  }) : age = 0;
}
