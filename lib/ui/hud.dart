import 'dart:math';

import 'package:flutter/material.dart';

import '../game/constants.dart';
import '../game/run_to_love_game.dart';
import 'theme.dart';

/// HUD during PLAYING / FINISH_CUTSCENE — pause button (top-right),
/// heart counter (top-left), micro-note overlay (bottom-center),
/// and cutscene text (center, during FINISH_CUTSCENE).
/// Taps pass through to the Flame game except on interactive elements.
class Hud extends StatelessWidget {
  final RunToLoveGame game;
  const Hud({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          // Heart counter — top-left
          Positioned(
            top: kSafePadding,
            left: kSafePadding,
            child: _HeartCounter(game: game),
          ),

          // Pause button — top-right (hidden during cutscene)
          Positioned(
            top: kSafePadding,
            right: kSafePadding,
            child: ValueListenableBuilder<GameState>(
              valueListenable: game.state,
              builder: (_, state, child) {
                if (state == GameState.finishCutscene) {
                  return const SizedBox.shrink();
                }
                return child!;
              },
              child: IconButton(
                iconSize: kHitTarget,
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.card.withValues(alpha: 0.6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () => game.pauseGame(),
                icon: const Icon(Icons.pause_rounded, color: AppColors.ink),
              ),
            ),
          ),

          // Cutscene text — center (during FINISH_CUTSCENE)
          Positioned.fill(
            child: _CutsceneTextDisplay(game: game),
          ),

          // Micro-note — bottom-center (non-blocking)
          Positioned(
            bottom: 80,
            left: kSafePadding,
            right: kSafePadding,
            child: _NoteDisplay(game: game),
          ),
        ],
      ),
    );
  }
}

/// Heart counter with icon + number.
class _HeartCounter extends StatelessWidget {
  final RunToLoveGame game;
  const _HeartCounter({required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: game.heartsCollected,
      builder: (_, count, _) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.card.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                '❤️',
                style: TextStyle(fontSize: 16, decoration: TextDecoration.none),
              ),
              const SizedBox(width: 4),
              Text(
                '$count',
                style: bodyStyle(fontSize: 22).copyWith(
                  color: AppColors.heart,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Cutscene text display — centered on screen during FINISH_CUTSCENE.
class _CutsceneTextDisplay extends StatelessWidget {
  final RunToLoveGame game;
  const _CutsceneTextDisplay({required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: game.cutsceneText,
      builder: (_, text, _) {
        if (text == null) return const SizedBox.shrink();
        return IgnorePointer(
          child: Center(
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.card.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                border:
                    Border.all(color: AppColors.yes.withValues(alpha: 0.4)),
              ),
              child: Text(
                text,
                style: headingStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Typewriter note display — appears when `activeNoteText` is non-null.
/// Does NOT block jump input (IgnorePointer wrapper).
class _NoteDisplay extends StatelessWidget {
  final RunToLoveGame game;
  const _NoteDisplay({required this.game});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: game.activeNoteText,
      builder: (_, text, _) {
        if (text == null) return const SizedBox.shrink();
        return IgnorePointer(
          child: Center(
            child: _TypewriterText(key: ValueKey(text), fullText: text),
          ),
        );
      },
    );
  }
}

/// Reveals text character-by-character, then holds.
class _TypewriterText extends StatefulWidget {
  final String fullText;
  const _TypewriterText({super.key, required this.fullText});

  @override
  State<_TypewriterText> createState() => _TypewriterTextState();
}

class _TypewriterTextState extends State<_TypewriterText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  int _charCount = 0;

  @override
  void initState() {
    super.initState();
    final totalChars = widget.fullText.length;
    final duration =
        Duration(milliseconds: (totalChars / kNoteTypewriterCps * 1000).round());
    _ctrl = AnimationController(vsync: this, duration: duration)
      ..addListener(() {
        final newCount =
            (widget.fullText.length * _ctrl.value).ceil();
        if (newCount != _charCount) {
          setState(() => _charCount = newCount);
        }
      })
      ..forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shown =
        widget.fullText.substring(0, min(_charCount, widget.fullText.length));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.card.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.ink.withValues(alpha: 0.3)),
      ),
      child: Text(
        shown,
        style: bodyStyle(fontSize: 22),
        textAlign: TextAlign.center,
      ),
    );
  }
}
