import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'game/run_to_love_game.dart';
import 'ui/celebration_screen.dart';
import 'ui/hud.dart';
import 'ui/pause_overlay.dart';
import 'ui/start_screen.dart';
import 'ui/theme.dart';
import 'ui/valentine_prompt.dart';

void main() {
  final game = RunToLoveGame();

  runApp(
    MaterialApp(
      title: 'Run to Love 💗',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.yes,
          brightness: Brightness.light,
        ),
      ),
      home: GameWidget<RunToLoveGame>(
        game: game,
        initialActiveOverlays: const ['startMenu'],
        overlayBuilderMap: {
          'startMenu': (ctx, g) => StartScreen(game: g),
          'hud': (ctx, g) => Hud(game: g),
          'pauseOverlay': (ctx, g) => PauseOverlay(game: g),
          'valentinePrompt': (ctx, g) => ValentinePrompt(game: g),
          'celebration': (ctx, g) => CelebrationScreen(game: g),
        },
      ),
    ),
  );
}
