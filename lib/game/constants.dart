/// Centralized tuning values — single source of truth.
/// All numbers sourced from docs/LEVEL_DATA.md.
library;

/// Immutable note definition (tile-X + text from docs/COPY.md).
class NoteData {
  final int tileX;
  final String text;
  const NoteData(this.tileX, this.text);
}

/// Heart placement — tile-X + height tier.
enum HeartTier { ground, low, high, boost }

class HeartPlacement {
  final int tileX;
  final HeartTier tier;
  const HeartPlacement(this.tileX, this.tier);
}

/// Obstacle type — 3 varieties per GAME_SPEC §6.
enum ObstacleType { spike, tallSpike, rock }

class ObstacleData {
  final int tileX;
  final ObstacleType type;
  const ObstacleData(this.tileX, this.type);
}

// ── Tile ──────────────────────────────────────────────
const double kTileSize = 32.0;

// ── World ─────────────────────────────────────────────
const int kTotalTilesX = 220;
const int kGroundYTile = 10;
const double kWorldWidth = kTotalTilesX * kTileSize;
const double kGroundY = kGroundYTile * kTileSize;

// ── Player ────────────────────────────────────────────
const int kStartXTile = 3;
const double kPlayerWidth = 28.0;
const double kPlayerHeight = 36.0;
const double kPlayerStartX = kStartXTile * kTileSize;
const double kPlayerStartY = kGroundY - kPlayerHeight;

// ── Auto-run (tune these) ─────────────────────────────
const double kRunSpeed = 130.0;
const double kJumpVelocity = -390.0;
const double kBoostJumpMultiplier = 1.4;
const int kDoubleTapWindowMs = 300;
const double kGravity = 820.0;
const double kMaxFallSpeed = 600.0;

// ── Debug ─────────────────────────────────────────────
const bool kDebugInput = false;

// ── Checkpoints (tile-X) ──────────────────────────────
const List<int> kCheckpointXTiles = [60, 120, 175];

// ── Hazards (typed) ───────────────────────────────────
const List<ObstacleData> kObstacles = [
  ObstacleData(35, ObstacleType.spike),
  ObstacleData(48, ObstacleType.rock),
  ObstacleData(92, ObstacleType.tallSpike),
  ObstacleData(108, ObstacleType.spike),
  ObstacleData(142, ObstacleType.rock),
  ObstacleData(160, ObstacleType.tallSpike),
];
const List<List<int>> kGapRanges = [
  [70, 73],
  [130, 134],
];
const double kGapFallThreshold = 80.0;

// ── Obstacle sizes ────────────────────────────────────
const double kSpikeWidth = 26.0;
const double kSpikeHeight = 26.0;
const double kTallSpikeWidth = 22.0;
const double kTallSpikeHeight = 40.0;
const double kRockWidth = 36.0;
const double kRockHeight = 20.0;

// ── Ground segments (derived from gap ranges) ─────────
const List<List<int>> kGroundSegments = [
  [0, 69],
  [74, 129],
  [135, 219],
];
const double kGroundThickness = 96.0;

// ── Hearts (varied heights) ──────────────────────────
const List<HeartPlacement> kHeartPlacements = [
  // Beat 0: easy intro — ground level, learn to collect
  HeartPlacement(10, HeartTier.ground),
  HeartPlacement(14, HeartTier.ground),
  HeartPlacement(18, HeartTier.low),
  // Beat 1-2: mix of heights
  HeartPlacement(42, HeartTier.high),
  HeartPlacement(55, HeartTier.low),
  HeartPlacement(66, HeartTier.ground),
  HeartPlacement(78, HeartTier.boost),
  // Beat 2-3: harder
  HeartPlacement(96, HeartTier.high),
  HeartPlacement(110, HeartTier.low),
  HeartPlacement(125, HeartTier.boost),
  // Beat 3-4: final stretch
  HeartPlacement(146, HeartTier.high),
  HeartPlacement(158, HeartTier.ground),
  HeartPlacement(170, HeartTier.low),
  HeartPlacement(182, HeartTier.boost),
];
// Height above ground per tier (px)
const double kHeartHeightGround = 20.0;
const double kHeartHeightLow = 52.0;
const double kHeartHeightHigh = 90.0;
const double kHeartHeightBoost = 130.0;
const double kHeartSize = 22.0;
const double kHeartPopDuration = 0.4;

// ── All-hearts bonus ─────────────────────────────────
const String kAllHeartsNote = 'You have ALL my love 💖';

// ── Scenery (decorative, no collision) ────────────────
const List<int> kTreeTiles = [7, 22, 50, 80, 100, 138, 155, 190, 208];
const List<int> kBushTiles = [5, 15, 30, 45, 62, 85, 115, 148, 172, 195];

// ── Micro-notes (text from docs/COPY.md) ──────────────
const int kNote1XTile = 25;
const int kNote2XTile = 105;
const int kNote3XTile = 165;
const List<NoteData> kNotes = [
  NoteData(kNote1XTile, 'You make ordinary days feel special.'),
  NoteData(kNote2XTile, "I'd jump any obstacle for you."),
  NoteData(kNote3XTile, 'Almost there…'),
];
const double kNoteDuration = 2.5;
const double kNoteTypewriterCps = 30;

// ── Finish / Cutscene ─────────────────────────────────
const int kFinishXTile = 205;
const int kQueenXTile = 212;
const double kQueenWidth = kPlayerWidth;
const double kQueenHeight = kPlayerHeight;
const double kPlayerQueenGap = 6.0;
const double kQueenWorldX = kQueenXTile * kTileSize;
const double kPlayerFinishX = kQueenWorldX - kPlayerWidth - kPlayerQueenGap;
const double kPlayerFinishY = kGroundY - kPlayerHeight;
const double kCutsceneTextDuration = 2.5;
const double kCutscenePauseDuration = 0.8;
const double kHeartParticleDuration = 2.5;

// ── Hit Recovery ──────────────────────────────────────
const double kHitRecoveryDuration = 0.8;
const double kCameraShakeIntensity = 4.0;
const double kCameraShakeDuration = 0.3;
