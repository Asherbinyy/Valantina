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

/// Obstacle type — spikes + bats per user spec.
enum ObstacleType { spike, bat }

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

// ── Player sprite sizing ──────────────────────────────
// Original sprite: 120×201px → display at 36×60 (0.3× scale)
const int kStartXTile = 3;
const double kPlayerWidth = 36.0;
const double kPlayerHeight = 60.0;
const double kPlayerStartX = kStartXTile * kTileSize;
const double kPlayerStartY = kGroundY - kPlayerHeight;

// ── Auto-run (tune these) ─────────────────────────────
const double kRunSpeed = 130.0;
const double kJumpVelocity = -390.0;
const double kBoostJumpMultiplier = 1.2;
const int kDoubleTapWindowMs = 300;
const double kGravity = 820.0;
const double kMaxFallSpeed = 600.0;

// ── Debug ─────────────────────────────────────────────
const bool kDebugInput = false;

// ── Checkpoints (tile-X) — placed BEFORE obstacles ───
const List<int> kCheckpointXTiles = [0, 40, 80, 115, 145];

// ── Hazards (typed: spikes + bats) ────────────────────
const List<ObstacleData> kObstacles = [
  ObstacleData(35, ObstacleType.spike),
  ObstacleData(57, ObstacleType.bat),
  ObstacleData(92, ObstacleType.spike),
  ObstacleData(108, ObstacleType.bat),
  ObstacleData(142, ObstacleType.spike),
  ObstacleData(160, ObstacleType.bat),
];
const List<List<int>> kGapRanges = [
  [70, 73],
  [130, 134],
];
const double kGapFallThreshold = 80.0;

// ── Obstacle sizes ────────────────────────────────────
// Spike sprite: 95×53 → display ~32×18 (0.34× scale)
const double kSpikeWidth = 32.0;
const double kSpikeHeight = 18.0;
// Bat sprite: 21×21 → display 28×28
const double kBatWidth = 28.0;
const double kBatHeight = 28.0;

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
// Heart sprite: 21×21 → display 24×24
const double kHeartSize = 24.0;
const double kHeartPopDuration = 0.4;

// ── All-hearts bonus ─────────────────────────────────
const String kAllHeartsNote = 'You have ALL my love 💖';

// ── Scenery (decorative, no collision) ────────────────
/// Scenery type for varied decorations.
enum SceneryType { grass1, grass2, mushroomRed, mushroomBrown, cactus }

class SceneryData {
  final int tileX;
  final SceneryType type;
  const SceneryData(this.tileX, this.type);
}

const List<SceneryData> kScenery = [
  SceneryData(5, SceneryType.grass1),
  SceneryData(7, SceneryType.mushroomRed),
  SceneryData(15, SceneryType.grass2),
  SceneryData(22, SceneryType.cactus),
  SceneryData(30, SceneryType.grass1),
  SceneryData(45, SceneryType.mushroomBrown),
  SceneryData(50, SceneryType.grass2),
  SceneryData(62, SceneryType.mushroomRed),
  SceneryData(80, SceneryType.grass1),
  SceneryData(85, SceneryType.cactus),
  SceneryData(100, SceneryType.grass2),
  SceneryData(115, SceneryType.mushroomBrown),
  SceneryData(138, SceneryType.grass1),
  SceneryData(148, SceneryType.mushroomRed),
  SceneryData(155, SceneryType.grass2),
  SceneryData(172, SceneryType.cactus),
  SceneryData(190, SceneryType.grass1),
  SceneryData(195, SceneryType.mushroomBrown),
];

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
// Queen uses same visual scale as player
const double kQueenWidth = kPlayerWidth;
const double kQueenHeight = kPlayerHeight;
const double kPlayerQueenGap = 8.0;
// Door: 2×2 tiles of 21px each → display 42×42
const double kDoorWidth = 42.0;
const double kDoorHeight = 42.0;
// Door is behind/between the characters
const double kDoorWorldX = kQueenXTile * kTileSize + kQueenWidth / 2 - kDoorWidth / 2;
const double kDoorWorldY = kGroundY - kDoorHeight;
// Player snap position: just left of queen, both grounded
const double kQueenWorldX = kQueenXTile * kTileSize;
const double kPlayerFinishX = kQueenWorldX - kPlayerWidth - kPlayerQueenGap;
const double kPlayerFinishY = kGroundY - kPlayerHeight;
// Cutscene timing
const double kCutsceneTextDuration = 2.5;
const double kCutscenePauseDuration = 0.8;
const double kHeartParticleDuration = 2.5;

// ── Hit Recovery ──────────────────────────────────────
const double kHitRecoveryDuration = 0.8;
const double kCameraShakeIntensity = 4.0;
const double kCameraShakeDuration = 0.3;
