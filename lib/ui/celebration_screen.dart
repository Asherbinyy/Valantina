import 'dart:math';

import 'package:flutter/material.dart';

import '../game/run_to_love_game.dart';
import 'theme.dart';

/// Celebration screen — confetti burst + final message + coupon + Restart.
/// Text from docs/COPY.md § Celebration screen.
class CelebrationScreen extends StatelessWidget {
  final RunToLoveGame game;
  const CelebrationScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          // Background gradient
          Container(decoration: const BoxDecoration(gradient: kBgGradient)),

          // Confetti overlay
          const Positioned.fill(child: _ConfettiOverlay()),

          // Content
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(kSafePadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'YAY!! 🎉',
                      style: headingStyle(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Happy Valentine's Day, my love.",
                      style: bodyStyle(fontSize: 26),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Coupon
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 14),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.yes, width: 2),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Coupon unlocked:',
                            style: bodyStyle(fontSize: 22)
                                .copyWith(color: AppColors.restart),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'A surprise date night with me ✨\n(details soon)',
                            style: bodyStyle(fontSize: 24)
                                .copyWith(color: AppColors.yes),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Play again
                    SizedBox(
                      width: 220,
                      height: kButtonMinHeight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.restart,
                          foregroundColor: AppColors.card,
                          textStyle: bodyStyle(fontSize: 22),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => game.restart(),
                        child: const Text('Play again'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '(optional) Take a screenshot 📸',
                      style: bodyStyle(fontSize: 20)
                          .copyWith(color: AppColors.restart),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Confetti particle system — colorful squares/rectangles falling from top.
/// Uses CustomPainter + AnimationController, no external dependencies.
class _ConfettiOverlay extends StatefulWidget {
  const _ConfettiOverlay();

  @override
  State<_ConfettiOverlay> createState() => _ConfettiOverlayState();
}

class _ConfettiOverlayState extends State<_ConfettiOverlay>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final List<_ConfettiPiece> _pieces;
  final Random _rng = Random();

  static const int _count = 80;
  static const List<Color> _colors = [
    Color(0xFFFF2D6F), // heart pink
    Color(0xFFFFD700), // gold
    Color(0xFF5DAE6B), // green
    Color(0xFF6EC6FF), // sky blue
    Color(0xFFFF8C42), // orange
    Color(0xFFE040FB), // magenta
  ];

  @override
  void initState() {
    super.initState();
    _pieces = List.generate(_count, (_) => _ConfettiPiece.random(_rng, _colors));
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )
      ..addListener(() => setState(() {}))
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: _ConfettiPainter(
          pieces: _pieces,
          progress: _ctrl.value,
        ),
        size: Size.infinite,
      ),
    );
  }
}

class _ConfettiPiece {
  final double startX; // 0..1 fraction of width
  final double startY; // negative = starts above screen
  final double speed; // fall speed multiplier
  final double wobble; // horizontal wobble amplitude
  final double wobbleFreq; // wobble frequency
  final double rotation; // rotation speed
  final double w, h; // piece dimensions
  final Color color;

  _ConfettiPiece({
    required this.startX,
    required this.startY,
    required this.speed,
    required this.wobble,
    required this.wobbleFreq,
    required this.rotation,
    required this.w,
    required this.h,
    required this.color,
  });

  factory _ConfettiPiece.random(Random rng, List<Color> colors) {
    return _ConfettiPiece(
      startX: rng.nextDouble(),
      startY: -rng.nextDouble() * 0.3 - 0.05,
      speed: 0.6 + rng.nextDouble() * 0.8,
      wobble: 10 + rng.nextDouble() * 25,
      wobbleFreq: 2 + rng.nextDouble() * 4,
      rotation: rng.nextDouble() * 10,
      w: 4 + rng.nextDouble() * 6,
      h: 6 + rng.nextDouble() * 10,
      color: colors[rng.nextInt(colors.length)],
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  final List<_ConfettiPiece> pieces;
  final double progress;

  _ConfettiPainter({required this.pieces, required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in pieces) {
      final t = progress * p.speed;
      final y = (p.startY + t * 1.5) * size.height;

      // Skip if off screen
      if (y > size.height + 20 || y < -30) continue;

      final x = p.startX * size.width +
          sin(progress * p.wobbleFreq * pi * 2) * p.wobble;

      // Fade out in last 20% of animation
      final alpha = progress > 0.8
          ? ((1.0 - progress) / 0.2).clamp(0.0, 1.0)
          : 1.0;

      final paint = Paint()
        ..color = p.color.withValues(alpha: alpha);

      canvas.save();
      canvas.translate(x, y);
      canvas.rotate(progress * p.rotation);
      canvas.drawRect(
        Rect.fromCenter(center: Offset.zero, width: p.w, height: p.h),
        paint,
      );
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(_ConfettiPainter old) => old.progress != progress;
}
