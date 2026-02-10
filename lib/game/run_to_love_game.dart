import 'dart:math';
import 'dart:developer' as developer;

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../ui/theme.dart';
import 'components/ground.dart';
import 'components/heart.dart';
import 'components/heart_particles.dart';
import 'components/obstacle.dart';
import 'components/player.dart';
import 'components/queen.dart';
import 'constants.dart';

/// Main game — state machine per docs/FLOWCHART.md.
class RunToLoveGame extends FlameGame
    with TapCallbacks, KeyboardEvents, HasCollisionDetection {
  late Player player;

  /// Current game state — UI listens via ValueNotifier.
  final ValueNotifier<GameState> state = ValueNotifier(GameState.startMenu);

  /// Sound toggle (visual only; wired to audio later).
  final ValueNotifier<bool> soundEnabled = ValueNotifier(true);

  /// Hearts collected — HUD listens.
  final ValueNotifier<int> heartsCollected = ValueNotifier(0);

  /// Active micro-note text — null means hidden. HUD listens.
  final ValueNotifier<String?> activeNoteText = ValueNotifier(null);

  /// Cutscene text — displayed during FINISH_CUTSCENE.
  final ValueNotifier<String?> cutsceneText = ValueNotifier(null);

  // Camera shake
  final Random _rng = Random();
  bool _shaking = false;
  double _shakeTimer = 0;

  // Note tracking
  final Set<int> _triggeredNoteIndices = {};
  double _noteTimer = 0;

  // Time tracking for heart bob
  double _elapsedTime = 0;
  double elapsedGameTime() => _elapsedTime;

  // Double-tap boost tracking
  DateTime _lastTapTime = DateTime(0);

  // ── Cutscene state ────────────────────────────────────
  double _cutsceneTimer = 0;
  // Phases: 0=text ("I found you 💖"), 1=pause, 2=done→valentine prompt
  int _cutscenePhase = 0;

  @override
  Color backgroundColor() => AppColors.bgTop;

  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _buildLevel();
  }

  // ── Level construction ───────────────────────────────

  void _buildLevel() {
    for (final seg in kGroundSegments) {
      world.add(GroundSegment(startTile: seg[0], endTile: seg[1]));
    }
    for (final tileX in kSpikeTiles) {
      world.add(Obstacle(tileX: tileX));
    }
    _spawnHearts();

    // Queen at end (same scale as player)
    world.add(Queen());

    // Player (added last = renders on top)
    player = Player();
    world.add(player);

    camera.follow(player, horizontalOnly: true);
    camera.viewfinder.anchor = Anchor.center;
  }

  void _spawnHearts() {
    for (final tileX in kHeartXTiles) {
      world.add(Heart(tileX: tileX));
    }
  }

  // ── Input ────────────────────────────────────────────

  void _handleJumpInput() {
    // Block input outside PLAYING state (cutscene, paused, etc.)
    if (state.value != GameState.playing) return;

    final now = DateTime.now();
    final elapsed = now.difference(_lastTapTime).inMilliseconds;
    final isDoubleTap = elapsed <= kDoubleTapWindowMs;

    if (kDebugInput) {
      developer.log('tap delta=${elapsed}ms doubleTap=$isDoubleTap '
          'onGround=${player.isOnGround} vy=${player.velocity.y.toStringAsFixed(1)}');
    }

    if (isDoubleTap) {
      // Retroactive boost: upgrade velocity if still ascending or on ground
      if (player.velocity.y < 0 || player.isOnGround) {
        player.velocity.y = kJumpVelocity * kBoostJumpMultiplier;
        if (player.isOnGround) {
          player.isOnGround = false;
        }
        if (kDebugInput) developer.log('  → BOOST applied');
      }
    } else {
      player.jump();
    }
    _lastTapTime = now;
  }

  @override
  void onTapDown(TapDownEvent event) {
    _handleJumpInput();
  }

  @override
  KeyEventResult onKeyEvent(
      KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.space) {
        _handleJumpInput();
        return KeyEventResult.handled;
      }
    }
    return KeyEventResult.ignored;
  }

  // ── Hearts ───────────────────────────────────────────

  void onHeartCollected() {
    heartsCollected.value++;
    // TODO: play "ting" SFX when audio is wired
  }

  // ── Micro-notes ──────────────────────────────────────

  void _checkNoteTriggers() {
    if (state.value != GameState.playing) return;
    for (int i = 0; i < kNotes.length; i++) {
      if (_triggeredNoteIndices.contains(i)) continue;
      if (player.position.x >= kNotes[i].tileX * kTileSize) {
        _triggeredNoteIndices.add(i);
        _showNote(kNotes[i].text);
        break;
      }
    }
  }

  void _showNote(String text) {
    activeNoteText.value = text;
    _noteTimer = kNoteDuration;
  }

  void _updateNoteTimer(double dt) {
    if (activeNoteText.value == null) return;
    _noteTimer -= dt;
    if (_noteTimer <= 0) {
      activeNoteText.value = null;
    }
  }

  // ── Finish trigger ──────────────────────────────────

  void _checkFinishTrigger() {
    if (state.value != GameState.playing) return;
    if (player.position.x >= kFinishXTile * kTileSize) {
      _startCutscene();
    }
  }

  /// Transition PLAYING → FINISH_CUTSCENE.
  /// - Snap player to deterministic final position (left of queen, grounded).
  /// - Zero velocity and disable gravity/collisions via inCutscene flag.
  /// - Player.update() will early-return since state != playing/hitRecovery.
  /// - Spawn heart particles, show cutscene text.
  void _startCutscene() {
    state.value = GameState.finishCutscene;

    // ── Freeze player ──
    player.inCutscene = true;
    player.velocity.setZero();
    player.isOnGround = true;

    // ── Deterministic snap: player just left of queen, both grounded ──
    player.position
      ..x = kPlayerFinishX
      ..y = kPlayerFinishY;

    // ── Pan camera to center on player+queen midpoint ──
    camera.stop();
    final midX = kPlayerFinishX + (kPlayerWidth + kPlayerQueenGap + kQueenWidth) / 2;
    camera.viewfinder.position = Vector2(midX, kPlayerFinishY + kPlayerHeight / 2);

    // ── Clear any active note ──
    activeNoteText.value = null;

    // ── Spawn heart particles ──
    world.add(HeartParticles());

    // ── Begin cutscene phases ──
    _cutscenePhase = 0; // phase 0: show text
    _cutsceneTimer = 0;
    cutsceneText.value = 'I found you 💖'; // from docs/COPY.md

    _syncOverlays();
  }

  void _updateCutscene(double dt) {
    if (state.value != GameState.finishCutscene) return;
    _cutsceneTimer += dt;

    switch (_cutscenePhase) {
      case 0: // "I found you 💖" display
        if (_cutsceneTimer >= kCutsceneTextDuration) {
          _cutscenePhase = 1;
          _cutsceneTimer = 0;
          cutsceneText.value = null; // hide text, pause
        }
      case 1: // pause before valentine prompt
        if (_cutsceneTimer >= kCutscenePauseDuration) {
          _cutscenePhase = 2;
          cutsceneText.value = null;
          // Transition to valentine prompt
          state.value = GameState.valentinePrompt;
          _syncOverlays();
        }
    }
  }

  // ── State transitions (per docs/FLOWCHART.md) ────────

  void startGame() {
    state.value = GameState.playing;
    _syncOverlays();
  }

  void pauseGame() {
    if (state.value != GameState.playing) return;
    state.value = GameState.paused;
    _syncOverlays();
  }

  void resumeGame() {
    if (state.value != GameState.paused) return;
    state.value = GameState.playing;
    _syncOverlays();
  }

  void triggerHitRecovery() {
    if (state.value != GameState.playing) return;
    state.value = GameState.hitRecovery;
    player.startRecovery();
    _startShake();
  }

  void finishHitRecovery() {
    state.value = GameState.playing;
  }

  void answerYes() {
    state.value = GameState.celebration;
    _syncOverlays();
  }

  /// Full restart per PROJECT_RULES.md §4.
  void restart() {
    state.value = GameState.restarting;

    player.fullReset();

    // Clean up hearts and particles
    world.children
        .whereType<Heart>()
        .toList()
        .forEach((h) => h.removeFromParent());
    world.children
        .whereType<HeartParticles>()
        .toList()
        .forEach((p) => p.removeFromParent());
    heartsCollected.value = 0;
    _spawnHearts();

    // Reset notes
    _triggeredNoteIndices.clear();
    activeNoteText.value = null;
    _noteTimer = 0;

    // Reset cutscene
    cutsceneText.value = null;
    _cutscenePhase = 0;
    _cutsceneTimer = 0;

    // Reset camera
    _shaking = false;
    _shakeTimer = 0;
    _lastTapTime = DateTime(0);

    // Re-follow player
    camera.follow(player, horizontalOnly: true);

    state.value = GameState.startMenu;
    _syncOverlays();
  }

  // ── Overlay management ───────────────────────────────

  void _syncOverlays() {
    overlays.remove('startMenu');
    overlays.remove('hud');
    overlays.remove('pauseOverlay');
    overlays.remove('valentinePrompt');
    overlays.remove('celebration');

    switch (state.value) {
      case GameState.startMenu:
        overlays.add('startMenu');
      case GameState.playing:
      case GameState.hitRecovery:
        overlays.add('hud');
      case GameState.paused:
        overlays.add('hud');
        overlays.add('pauseOverlay');
      case GameState.finishCutscene:
        overlays.add('hud'); // heart count stays visible
      case GameState.valentinePrompt:
        overlays.add('valentinePrompt');
      case GameState.celebration:
        overlays.add('celebration');
      default:
        break;
    }
  }

  // ── Camera shake ─────────────────────────────────────

  void _startShake() {
    _shaking = true;
    _shakeTimer = kCameraShakeDuration;
  }

  @override
  void update(double dt) {
    super.update(dt);
    _elapsedTime += dt;

    _checkNoteTriggers();
    _updateNoteTimer(dt);
    _checkFinishTrigger();
    _updateCutscene(dt);

    if (_shaking) {
      _shakeTimer -= dt;
      if (_shakeTimer <= 0) {
        _shaking = false;
      } else {
        camera.viewfinder.position = player.position +
            Vector2(
              (_rng.nextDouble() - 0.5) * kCameraShakeIntensity * 2,
              (_rng.nextDouble() - 0.5) * kCameraShakeIntensity * 2,
            );
      }
    }
  }
}

/// Game states — maps 1:1 to docs/GAME_SPEC.md §5 and docs/FLOWCHART.md.
enum GameState {
  boot,
  startMenu,
  playing,
  paused,
  hitRecovery,
  finishCutscene,
  valentinePrompt,
  celebration,
  restarting,
}
