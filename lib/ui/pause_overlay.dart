import 'package:flutter/material.dart';

import '../game/run_to_love_game.dart';
import 'theme.dart';

/// Pause overlay — Resume + Restart + Sound toggle.
/// Per docs/GAME_SPEC.md §14.
class PauseOverlay extends StatelessWidget {
  final RunToLoveGame game;
  const PauseOverlay({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ink.withValues(alpha: 0.65),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 320),
          margin: const EdgeInsets.all(kSafePadding),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 28),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Paused', style: headingStyle(fontSize: 20)),
              const SizedBox(height: 28),
              _button('Resume', AppColors.yes, () => game.resumeGame()),
              const SizedBox(height: 12),
              _button('Restart', AppColors.restart, () => game.restart()),
              const SizedBox(height: 20),
              _SoundRow(game: game),
            ],
          ),
        ),
      ),
    );
  }

  Widget _button(String label, Color color, VoidCallback onTap) {
    return SizedBox(
      width: double.infinity,
      height: kButtonMinHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: AppColors.card,
          textStyle: bodyStyle(fontSize: 22),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}

class _SoundRow extends StatelessWidget {
  final RunToLoveGame game;
  const _SoundRow({required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: game.soundEnabled,
      builder: (_, on, _) {
        return IconButton(
          iconSize: kHitTarget,
          onPressed: () => game.soundEnabled.value = !on,
          icon: Icon(
            on ? Icons.volume_up_rounded : Icons.volume_off_rounded,
            color: AppColors.ink,
          ),
        );
      },
    );
  }
}
