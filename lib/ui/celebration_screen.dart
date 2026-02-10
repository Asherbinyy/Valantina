import 'package:flutter/material.dart';

import '../game/run_to_love_game.dart';
import 'theme.dart';

/// Celebration screen — final message + coupon + Restart.
/// Text from docs/COPY.md § Celebration screen.
class CelebrationScreen extends StatelessWidget {
  final RunToLoveGame game;
  const CelebrationScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        decoration: const BoxDecoration(gradient: kBgGradient),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(kSafePadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  Text(
                    'YAY!! 🎉',
                    style: headingStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Message
                  Text(
                    'Happy Valentine\'s Day, my love.',
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
                  // Restart / Play again
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
                  // Screenshot hint
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
      ),
    );
  }
}
