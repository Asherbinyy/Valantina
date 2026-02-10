import 'package:flutter/material.dart';

import '../game/run_to_love_game.dart';
import 'theme.dart';

/// Start menu overlay — all text sourced from docs/COPY.md.
class StartScreen extends StatelessWidget {
  final RunToLoveGame game;
  const StartScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => game.startGame(),
        child: Container(
          decoration: const BoxDecoration(gradient: kBgGradient),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: kSafePadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 3),
                  // ── Title ──
                  Text(
                    'Run to Love 💗',
                    style: headingStyle(fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  // ── Subtitle ──
                  Text(
                    'A tiny game I made for you.',
                    style: bodyStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(flex: 2),
                  // ── CTA (pulsing) ──
                  const _PulsingCta(),
                  const Spacer(flex: 1),
                  // ── Sound toggle ──
                  _SoundToggle(game: game),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Pulsing "Tap to start" text — simple AnimatedOpacity loop.
class _PulsingCta extends StatefulWidget {
  const _PulsingCta();

  @override
  State<_PulsingCta> createState() => _PulsingCtaState();
}

class _PulsingCtaState extends State<_PulsingCta>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _opacity = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: Text(
        'Tap to start',
        style: bodyStyle(fontSize: 26).copyWith(color: AppColors.yes),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// Sound on/off toggle icon. No audio I/O yet — visual state only.
class _SoundToggle extends StatelessWidget {
  final RunToLoveGame game;
  const _SoundToggle({required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: game.soundEnabled,
      builder: (_, enabled, _) {
        return IconButton(
          iconSize: kHitTarget,
          onPressed: () {
            game.soundEnabled.value = !game.soundEnabled.value;
          },
          icon: Icon(
            enabled ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            color: AppColors.ink,
          ),
          tooltip: enabled ? 'Mute' : 'Unmute',
        );
      },
    );
  }
}
