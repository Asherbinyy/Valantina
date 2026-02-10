import 'package:flutter/material.dart';

import '../game/run_to_love_game.dart';
import 'theme.dart';

/// Valentine prompt — "Will you be my Valentine?" + YES + Restart.
/// Text from docs/COPY.md § Valentine prompt.
class ValentinePrompt extends StatelessWidget {
  final RunToLoveGame game;
  const ValentinePrompt({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(gradient: kBgGradient),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 340),
            margin: const EdgeInsets.all(kSafePadding),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 32),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Will you be my\nValentine? 💖',
                  style: headingStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: kButtonMinHeight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.yes,
                      foregroundColor: AppColors.card,
                      textStyle: bodyStyle(fontSize: 24),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => game.answerYes(),
                    child: const Text('YES!'),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
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
                    child: const Text('Restart'),
                  ),
                ),
                const SizedBox(height: 16),
                _SoundToggle(game: game),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SoundToggle extends StatelessWidget {
  final RunToLoveGame game;
  const _SoundToggle({required this.game});

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
